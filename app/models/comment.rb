class Comment < ActiveRecord::Base
  self.per_page = 10

  def display_date
    # We show comments in central time
    created_at.in_time_zone("Central Time (US & Canada)").strftime("%m-%d-%Y at %I:%M %p")
  end
end
