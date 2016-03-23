class BookmarksController < ApplicationController
  before_action :authenticate_user!, except: [:show]


  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
    @bookmark.user_id = current_user.id
    authorize @bookmark
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)
    authorize @bookmark

    if @bookmark.save
      flash[:notice] = "Bookmark was updated."
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash.now[:alert] = "There was an error saving the Bookmark. Please try again. "
      render :edit
    end
  end

  def create

    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user_id = current_user.id
    authorize @bookmark

        if @bookmark.save
          flash[:notice] = "\"#{@bookmark.url}\" was created successfully."
          redirect_to [@topic, @post]
        else
          flash.now[:alert] = "Error creating Bookmark. Please try again"
          render :new
        end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
      if @bookmark.destroy
        flash[:notice] = "\"#{@bookmark.url}\" was deleted successfully."
        redirect_to @bookmark.topic
      else
        flash.now[:alert] = "There was an error deleteing the Bookmark."
        renders :show
      end
  end

  private
    def bookmark_params
      params.require(:bookmark).permit(:url)
    end
end
