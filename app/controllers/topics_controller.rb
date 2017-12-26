class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find_by(name: params[:name])
    @chart_data = ChartData.new(@topic)
  end
end
