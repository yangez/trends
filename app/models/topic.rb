class Topic < ApplicationRecord
  validates :name, presence: true


  has_many :snapshots

  def subreddit_name
    "/r/#{name}"
  end

  def subreddit_url
    "https://www.reddit.com/r/#{name}"
  end

  def delta(period)
    previous = snapshot_from_last :hour
    return if previous.nil?

    now = snapshots.last

    (now.activity_ratio - previous.activity_ratio) / previous.activity_ratio
  end

  VALID_PERIODS = %i(hour)
  def snapshot_from_last(period)
    return unless VALID_PERIODS.include? period
    created_at = snapshots.last.created_at
    snapshots.find_by(created_at: (created_at - 1.public_send(period))...created_at)
  end
end
