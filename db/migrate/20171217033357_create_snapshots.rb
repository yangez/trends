class CreateSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :snapshots do |t|
      t.belongs_to :topic
      t.integer :active_user_count
      t.integer :subscribers

      t.timestamps
    end
  end
end
