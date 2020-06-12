class ChaptersController < ApplicationController
  def new
    @courses = Course.includes(:chapter)
    @chapter = Chapter.new
  end

  def create
    authorize current_user
    @chapter = Chapter.new(params_chapter)
    @material = Material.find(params[:chapter][:material])
    @chapter.material = @material
    if @chapter.save
      redirect_to materials_path
    else
      render 'shared/navbar_teacher_courses'
    end
  end

  def edit
  end

  def update
    authorize current_user
    @chapter = Chapter.find(params[:id])
    if @chapter.update(params_chapter)
      redirect_to material_path(@chapter.material)
    else
      render 'shared/navbar_teacher_courses'
    end
  end

  def destroy
    authorize current_user
    @chapter = Chapter.find(params[:id])
    @material = @chapter.material
    @chapter.destroy
    redirect_to material_path(@material)
  end

  private

  def params_chapter
    params.require(:chapter).permit(:name, :content)
  end
end
