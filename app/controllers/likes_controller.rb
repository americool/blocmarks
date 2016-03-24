class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

   if like.save
     flash[:notice] = "You have liked this bookmark!"
     redirect_to [@bookmark.topic, @bookmark]
   else
     flash[:notice] = "Unable to like bookmark, please try again."
     redirect_to [@bookmark.topic, @bookmark]
   end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])

   if like.destroy
     flash[:notice] = "You have unliked this bookmark!"
     redirect_to [@bookmark.topic, @bookmark]
   else
     flash[:notice] = "Unable to unlike bookmark, please try again."
     redirect_to [@bookmark.topic, @bookmark]
   end
  end
end
