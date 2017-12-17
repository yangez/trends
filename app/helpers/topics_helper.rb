module TopicsHelper
  def activity_ratio(topic)
    number_to_percentage(topic.activity_ratio*100)
  end
end
