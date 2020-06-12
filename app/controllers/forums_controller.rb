class ForumsController < ApplicationController

  def index
    messages
  end

  def show
    @course  = Course.where("forum_id = ?", params[:id])
  end

end
