# View object for formatted data for Topics#show
module Topics
  class ChartData < BaseService
    attr_reader :topic
    delegate :subreddit_name, to: :topic

    Card = Struct.new(:value, :delta)

    def initialize(topic)
      @topic = topic
    end

    def active_user_count
      card_for_type(:active_user_count)
    end

    def subscribers
      card_for_type(:subscribers)
    end

    def activity_ratio
      card_for_type(:activity_ratio)
    end

    def labels
      snapshots.map { |s| s.created_at.strftime('%l%P') }
    end

    def data
      snapshots.map { |s| (s.activity_ratio*100).round(3) }
    end

    protected

    def card_for_type(type)
      Card.new(
        topic.public_send(type),
        Snapshots::Delta.new(snapshots[-1], snapshots[-2], type: type, interval: :hour).value
      )
    end

    def snapshots
      Topics::Traverse.new(topic).snapshots
    end
    memoize :snapshots

  end
end
