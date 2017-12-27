class CreateSnapshotForTopic
  include Interactor
  extend Memoist

  delegate :topic, to: :context
  delegate :name, to: :topic

  def call
    Topic.transaction do
      topic.snapshots.create(final_params)
      topic.update(final_params)
    end
    puts "Finished syncing #{topic.name}."
  end

  protected

  def final_params
    initial_params.merge(delta: {
      hour: Snapshots::Delta.new(
        topic.snapshots.new(initial_params),
        latest_snapshot,
        type: :activity_ratio,
        interval: :hour).value
    })
  end

  def initial_params
    {
      active_user_count: active_user_count,
      subscribers: subscribers,
      activity_ratio: activity_ratio
    }
  end

  def active_user_count
    reddit_data["active_user_count"]
  end

  def subscribers
    reddit_data["subscribers"]
  end

  def activity_ratio
    active_user_count*1.0 / subscribers
  end

  def latest_snapshot
    Topics::Traverse.new(topic, :hour).current
  end
  memoize :latest_snapshot

  def reddit_data
    JSON.parse(reddit_request.body)["data"]
  end
  memoize :reddit_data

  def reddit_request
    HTTParty.get("https://reddit.com/r/#{name}/about.json", headers: { 'User-agent': 'KissTrends 0.1' } )
  end
  memoize :reddit_request

end
