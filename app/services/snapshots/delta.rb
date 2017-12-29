# Calculates delta between two snapshots

module Snapshots
  class Delta < BaseService
    attr_reader :previous, :current, :type, :interval

    VALID_INTERVALS = %i(hour)
    VALID_TYPES = %i(activity_ratio subscribers active_user_count)

    class InvalidIntervalError < StandardError; end
    class InvalidTypeError < StandardError; end

    def initialize(current, previous, type: :activity_ratio, interval: :hour)
      fail InvalidIntervalError unless VALID_INTERVALS.include? interval
      fail InvalidTypeError unless VALID_TYPES.include? type

      @previous, @current, @type, @interval = previous, current, type, interval
    end

    def value
      return if previous.nil? || current.nil?
      1.0 * (current.public_send(type) - previous.public_send(type)) / previous.public_send(type)
    end

  end
end
