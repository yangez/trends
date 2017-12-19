namespace :backpopulate do
  task deltas: :environment do
    Snapshot.where(delta: [nil, '{}']).order(id: :asc).find_each do |s|
      previous = s.topic.snapshots.find_by(
        created_at: s.created_at - 1.hour - 5.minutes...s.created_at
      )
      s.update_attribute :delta, { hour: (s.activity_ratio - previous.activity_ratio) / previous.activity_ratio } if previous.present?
      puts "Snapshot ##{s.id} back-populated."
    end

    Topic.where(delta: [nil, '{}']).find_each do |t|
      snapshot = t.snapshots.last
      t.update_attribute :delta, snapshot.delta
      puts "Topic ##{t.id} back-populated."
    end

  end
end
