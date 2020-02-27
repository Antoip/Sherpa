class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages
  has_many :user_answers
  has_many :teacher_divisions
  has_many :divisions, through: :teacher_divisions
  belongs_to :division, optional: true


  validates :role, inclusion: { in: %w[teacher student admin] }

  def teacher?
    role == "teacher"
  end

  def courses
    self.divisions.map(&:courses).flatten
  end

  def score(material)
    chapter_scores = material.chapters.map { |chapter| flashcards_score(chapter) }
    chapter_scores.sum.fdiv(chapter_scores.length).round
  end

  def flashcards_score(chapter)
    student_flashcards = material.find_flashcards_answers_by_student(self)
    score = student_flashcards.map {|student_flashcard| student_flashcard.completion }.sum
    score.fdiv(material.flashcards_number).round
  end
end
