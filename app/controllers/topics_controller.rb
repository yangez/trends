class TopicsController < ApplicationController
  def index
    @topics = Topic.order(activity_ratio: :desc)
  end

  def show
    @topic = Topic.find_by(name: params[:name])
  end
end
