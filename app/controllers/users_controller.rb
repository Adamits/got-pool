class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @guesses = @user.guesses.sort_by {|g| g.created_at}
    @characters = Character.all.sort_by {|c| c.questions.first.created_at}
    @characters.reverse!
  end
end
