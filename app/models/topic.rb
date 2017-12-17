class Topic < ApplicationRecord
  validates :name, presence: true

  has_many :snapshots

  def subreddit_name
    "/r/#{name}"
  end

end
