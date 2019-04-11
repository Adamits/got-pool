class UpdatesController < ApplicationController
  def index
    @characters = Character.all.sort_by {|c| c.questions.first.updated_at}
    @characters.reverse!
    @active = "characters"
  end
end
