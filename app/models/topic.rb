class Topic < ApplicationRecord
  validates :name, presence: true

  has_many :snapshots

  def subreddit_name
    "/r/#{name}"
  end

  def active_user_count
    snapshots.last.active_user_count
  end

  def subscribers
    snapshots.last.subscribers
  end

  def activity_ratio
    snapshots.last.activity_ratio
  end

end
