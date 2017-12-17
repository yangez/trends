class AddDataToTopic < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :active_user_count, :integer
    add_column :topics, :subscribers, :integer
    add_column :topics, :activity_ratio, :decimal
  end
end
