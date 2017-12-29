# Responsible for traversing between snapshots from a single topic
# Currently only works for :hour
module Topics
  class Traverse < BaseService
    extend Memoist
    attr_reader :topic, :interval

    class InvalidIntervalError < StandardError; end

    VALID_INTERVALS = %i(hour)

    def initialize(topic, interval=:hour)
      fail InvalidIntervalError unless VALID_INTERVALS.include? interval
      @topic = topic
      @interval = interval
    end

    def current
      snapshots.last
    end

    def previous
      snapshots[-2]
    end

    def snapshots
      topic.snapshots.order(id: :desc).limit(24).reverse
    end
    memoize :snapshots

  end
end
