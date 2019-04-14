class HomeController < ApplicationController
  def index
    @users = User.all.sort_by {|u| -u.points}
    @characters = Character.all.sort_by {|c| c.questions.first.created_at}
    @characters.reverse!
    @comment = Comment.new
    @comments = Comment.order(created_at: :desc).paginate(page: params[:page])
    @active = "users"
  end
end
