class Teachers::FlashcardsController < ApplicationController

  def index
    authorize current_user
    policy_scope(Flashcard)
    @materials = []
    @levels = []
    @user = current_user
    @chapters = Chapter.includes([:flashcards])
    @courses = Course.where("user_id = '#{@user.id}'").includes([:material, :division])
    @courses.each { |course| @materials << course.material && @levels << course.division.level}

    @levels = @levels.uniq
    @materials_display = []
  end

  def update
    authorize current_user
    @flashcard = Flashcard.find(params[:id])
    if @flashcard.update(params_flash)
      redirect_to teachers_flashcards_path
    else
      render :new
    end
  end

  def destroy
        authorize current_user
    @flashcard = Flashcard.find(params[:id])
    @flashcard.destroy
    redirect_to teachers_flashcards_path
  end

  private

  def params_flash
    params.require(:flashcard).permit(:question, :answer)
  end

end
