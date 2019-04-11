class Guess < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  validates :question, uniqueness: {scope: :user}
  validates :user, presence: true

  def correct?
    if question.answered
      question.answer == text \
      or (question.answer.include?("Dead") && text.include?("Dead")) \
      or (question.answer.include?("White Walker") && text.include?("White Walker")) \
      or (question.answer.include?("White Walker") && text.include?("Dead"))
    else
      false
    end
  end

  def extra_points?
    text.include?("White Walker") && correct?
  end

  def negative_points?
    text.include?("White Walker") && !correct?
  end

  def set_state
    self.correct = correct?
    self.extra_points = extra_points?
    self.negative_points = negative_points?
    self.save
  end

  def update_user_points
    user.points += points
    user.save!
  end
end
