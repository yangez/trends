class Snapshot < ApplicationRecord
  validates :active_user_count, :subscribers, presence: true

  belongs_to :topic

  def activity_ratio
    active_user_count * 1.0 / subscribers
  end

end
