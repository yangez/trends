namespace :sync do
  task topics: :environment do
    CreateSnapshotsForAllTopics.call
  end
end
