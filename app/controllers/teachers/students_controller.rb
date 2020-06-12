class Teachers::StudentsController < ApplicationController

  def index
  end

  def show
    authorize current_user
  end
end
