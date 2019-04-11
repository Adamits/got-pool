class Question < ActiveRecord::Base
  belongs_to :character
  has_many :guesses
  validates :text, uniqueness: :true

  def set_answer(a)
    self.answer = a
    self.answered = true
    self.save
    update_guess_states
    update_user_points
  end

  private
  def update_guess_states
    guesses.all.map {|g| g.set_state}
  end

  def update_user_points
    User.all.each do |user|
      user.calculate_points!
    end
    #guesses.each do |guess|
    #  guess.update_user_points
    #end
  end
end
