class AddActivityRatioToSnapshot < ActiveRecord::Migration[5.1]
  def change
    add_column :snapshots, :activity_ratio, :decimal, null: false
  end
end
