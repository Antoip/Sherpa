class Teachers::FeedbacksController < ApplicationController
  def index
    authorize current_user
    policy_scope(Feedback)
    @course  = Course.find(params[:format])
    @course_students = User.where("division_id = ?", @course.division.id).includes([:feedbacks, :division])

    @students_feedbacks = []
    @course_students.each do |student|
      student.feedbacks.each do |feedback|
        @students_feedbacks << feedback if feedback.course == @course
      end
    end

    @students_rating_five_stars = []
    @students_rating_four_stars = []
    @students_rating_three_stars = []
    @students_rating_two_stars = []
    @students_rating_one_stars = []

    @students_feedbacks.each do |feedback|
      if feedback.rating == 5
        @students_rating_five_stars << feedback.rating
      elsif feedback.rating == 4
        @students_rating_four_stars << feedback.rating
      elsif feedback.rating == 3
        @students_rating_three_stars << feedback.rating
      elsif feedback.rating == 2
        @students_rating_two_stars << feedback.rating
      else @students_rating_one_stars << feedback.rating
      end
    end

    @students_rating_five_stars_percentage = @students_rating_five_stars.length.fdiv(@students_feedbacks.length).round(2) * 100
    @students_rating_four_stars_percentage = @students_rating_four_stars.length.fdiv(@students_feedbacks.length).round(2) * 100
    @students_rating_three_stars_percentage = @students_rating_three_stars.length.fdiv(@students_feedbacks.length).round(2) * 100
    @students_rating_two_stars_percentage = @students_rating_two_stars.length.fdiv(@students_feedbacks.length).round(2) * 100
    @students_rating_one_stars_percentage = @students_rating_one_stars.length.fdiv(@students_feedbacks.length).round(2) * 100

    @teacher_reviews = {
      "5 stars" => @students_rating_five_stars_percentage,
      "4 stars" => @students_rating_four_stars_percentage,
      "3 stars" => @students_rating_three_stars_percentage,
      "2 stars" => @students_rating_two_stars_percentage,
      "1 star" => @students_rating_one_stars_percentage
    }

    @sum_reviews = 0
    @students_feedbacks.each do |feedback|
      @sum_reviews += feedback.rating
    end

    @reviews_summary_rounded = @sum_reviews / @students_feedbacks.length
    @reviews_summary_rounded_half = ((@sum_reviews.fdiv(@students_feedbacks.length).round(1)) * 2.0).round() / 2.0

  end
end
