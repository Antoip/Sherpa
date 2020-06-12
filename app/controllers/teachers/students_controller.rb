class Teachers::StudentsController < ApplicationController

  def index
    authorize current_user
    policy_scope(User)
    @course  = Course.find(params[:course_id])
    @course_students = User.where("division_id = ?", @course.division.id).includes([:feedbacks, :division])
    @material = @course.material

    @student_sentiment_score_flashcards_score = {}

    @new_course_students = @course_students.sort_by.with_index do |student, index|
      score = student.score(@material)
      sentiment = student.sentiment_score(@course)

      if score >= 65 && sentiment >= 50
        @student_sentiment_score_flashcards_score[student.id] = { x: score , y: sentiment, color: "green" }

      elsif score >= 65 && sentiment < 50
        @student_sentiment_score_flashcards_score[student.id] = { x: score , y: sentiment, color: "blue" }

      elsif score < 65 && sentiment >= 50
        @student_sentiment_score_flashcards_score[student.id] = { x: score , y: sentiment, color: "purple" }

      else @student_sentiment_score_flashcards_score[student.id] = { x: score , y: sentiment, color: "red" }
      end
      score
    end

  @list_students_without_top_offender = @new_course_students.drop(5)

  end

  def show
    authorize current_user
  end
end
