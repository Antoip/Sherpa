class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :course

  NOTIFICATION_TYPES = ['flashcards', 'feeling', 'message', 'feedback']

  validates :notif_type, presence: true,
                   inclusion: { in: NOTIFICATION_TYPES }
                   # uniqueness: { scope: :course_id }

  validates :content, presence: true

  def mark_as_read
    self.read_status = true
    self.save
  end

end
