class CreateSnapshotsForAllTopics
  include Interactor
  extend Memoist

  def call
    Topic.find_each do |topic|
      CreateSnapshotForTopic.call(topic: topic)
    end
  end
end
