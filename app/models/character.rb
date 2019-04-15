class Character < ActiveRecord::Base
  has_many :questions

  validates :name, uniqueness: true
  after_save :update_question, if: :status_changed?

  def alive?
    status == "Alive"
  end

  def dead?
    whitewalker? or status.include?("Dead")
  end

  def whitewalker?
    status.include?("White Walker")
  end

  def status_error?
    not ["Alive", "Dead", "White Walker"].include?(status)
  end

  def get_filename
    filename || "/images/missing.png"
  end

  def get_image_url
    Rails.root.join('app', 'assets', 'images', get_filename)
  end

  private
  def update_question
    self.questions.each do |q|
      q.set_answer(status)
    end
  end
end
