class Teachers::TeachersController < ApplicationController
  include Pundit
  # before_action :verify_authorized, except: :show, unless: :skip_pundit?

  def show
    authorize current_user

    @divisions = current_user.divisions
    @courses = Course.where(user_id: current_user.id).includes([:material, :division])
    @unread_flashcards_notifications = Notification.where(user_id: current_user.id).where(notif_type: "flashcards").where(read_status: false).includes([:course])
    @unread_feeling_notifications    = Notification.where(user_id: current_user.id).where(notif_type: "feeling").where(read_status: false).includes([:course])
    @unread_message_notifications    = Notification.where(user_id: current_user.id).where(notif_type: "message").where(read_status: false).includes([:course])
    @unread_feedback_notifications   = Notification.where(user_id: current_user.id).where(notif_type: "feedback").where(read_status: false).includes([:course])
  end

  def trigger_score_notifications
    authorize(current_user)
    current_user.flashcards_notifications
    current_user.feeling_notifications
    redirect_to teachers_root_path
  end

end
