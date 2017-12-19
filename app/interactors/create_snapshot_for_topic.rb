class CreateSnapshotForTopic
  include Interactor
  extend Memoist

  delegate :topic, to: :context
  delegate :name, to: :topic

  def call
    Topic.transaction do
      topic.snapshots.create(data_params)
      topic.update(data_params)
    end
    puts "Finished syncing #{topic.name}."
  end

  protected

  def data_params
    {
      active_user_count: active_user_count,
      subscribers: subscribers,
      activity_ratio: activity_ratio,
      delta: {
        hour: delta_for(:hour)
      }
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

  def delta_for(period)
    previous = snapshot_from_last period
    return if previous.nil?
    
    (activity_ratio - previous.activity_ratio) / previous.activity_ratio
  end

  VALID_PERIODS = %i(hour)
  def snapshot_from_last(period)
    return unless VALID_PERIODS.include? period
    topic.snapshots.find_by(created_at: 1.public_send(period).ago-5.minutes...Time.current)
  end

  protected

  def reddit_data
    JSON.parse(reddit_request.body)["data"]
  end
  memoize :reddit_data

  def reddit_request
    HTTParty.get("https://reddit.com/r/#{name}/about.json", headers: { 'User-agent': 'KissTrends 0.1' } )
  end
  memoize :reddit_request

end
