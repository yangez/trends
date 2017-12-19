class Topic < ApplicationRecord
  validates :name, presence: true

  has_many :snapshots

  def subreddit_name
    "/r/#{name}"
  end

  def subreddit_url
    "https://www.reddit.com/r/#{name}"
  end

  def delta_hour
    delta.try(:[], 'hour')
  end
end
