class ChartData
  attr_reader :topic

  def initialize(topic)
    @topic = topic
  end

  def labels
    snapshots.map { |s| s.created_at.strftime('%l%P') }
  end

  def data
    snapshots.map { |s| (s.activity_ratio*100).round(2) }
  end

  protected

  def snapshots
    topic.snapshots.order(id: :desc).limit(24).reverse
  end

end
