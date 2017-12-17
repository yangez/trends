class TopicsController < ApplicationController
  def show
    @topic = Topic.find_by(name: params[:name])
  end
end
