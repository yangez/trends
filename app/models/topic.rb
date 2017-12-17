class Topic < ApplicationRecord
  validates :name, presence: true

  has_many :snapshots

  def subreddit_name
    "/r/#{name}"
  end

  def subreddit_url
    "https://www.reddit.com/r/#{name}"
  end

  VALID_PERIODS = %i(hour)

  def delta(period)
    return unless VALID_PERIODS.include? period
    last = snapshots.last
    previous = snapshots.last(2).first
    return if last == previous

    (last.activity_ratio - previous.activity_ratio) / last.activity_ratio
  end
end
