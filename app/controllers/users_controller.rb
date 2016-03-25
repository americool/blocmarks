class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks.all
    @likes = @user.likes.all
  end
end
