class Topic < ApplicationRecord
  validates :name, presence: true

  def subreddit_name
    "/r/#{name}"
  end
end
