class CreateSnapshotForTopic
  include Interactor
  extend Memoist

  delegate :topic, to: :context
  delegate :name, to: :topic

  def call
    topic.snapshots.create(data_params)
  end

  protected

  def data_params
    {
      topic: topic,
      active_user_count: active_user_count,
      subscribers: subscribers
    }
  end

  def active_user_count
    reddit_data["active_user_count"]
  end

  def subscribers
    reddit_data["subscribers"]
  end

  def reddit_data
    JSON.parse(reddit_request.body)["data"]
  end
  memoize :reddit_data

  def reddit_request
    HTTParty.get("https://reddit.com/r/#{name}/about.json", headers: { 'User-agent': 'KissTrends 0.1' } )
  end
  memoize :reddit_request

end
