class AddDeltaToTopicAndSnapshot < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :delta, :jsonb
    add_column :snapshots, :delta, :jsonb
  end
end
