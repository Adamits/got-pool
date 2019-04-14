class Guess < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  validates :question, uniqueness: {scope: :user}
  validates :user, presence: true

  def correct?
    # Cases are:
    # Alive, Dead, or White walker
    # But White walker implies dead, and
    # predicting dead is still correct if they become a white walker
    if question.answered
      question.answer == text \
      or (question.answer.include?("Dead") && text == "Dead") \
      or (question.answer.include?("White Walker") && text == "Dead") \
      or (question.answer.include?("White Walker") && text.include?("White Walker"))
    else
      false
    end
  end

  def extra_points?
    text.include?("White Walker") && question.answer.include?("White Walker")
  end

  def negative_points?
    # Only lose a point if the character dies, and you predicted white walker
    text.include?("White Walker") && question.answer == "Dead"
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
