class MaterialsController < ApplicationController
  include Pundit

  def index
    @teacher = current_user
    authorize @teacher
    policy_scope(Material)
    @chapter = Chapter.new
    @materials = []
    @levels = []
    @teacher.courses.each { |course| @materials << course.material && @levels << course.division.level}
    @levels = @levels.uniq
    @materials_display = []

  end

  def show
    @teacher = current_user
    authorize @teacher
    policy_scope(Material)
    @material= Material.find(params[:id])
  end

  # def new
  #   @course  = Course.find(params[:id])
  #   @chapter = Chapter.new
  # end

end

