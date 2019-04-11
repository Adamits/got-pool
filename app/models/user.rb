class User < ActiveRecord::Base
  has_many :guesses

  validates :name, presence: true
  validates :name, uniqueness: true

  def calculate_points!
    p = guesses.where(correct: true).count
    p += guesses.where(extra_points: true).count
    p -= guesses.where(negative_points: true).count
    self.points = p
    self.save!
  end
end
