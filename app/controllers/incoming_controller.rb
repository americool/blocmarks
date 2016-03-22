class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create

    # You put the message-splitting and business
    # magic here.

    # Find the user by using params[:sender]
    p "Hello!"
    p params[:sender]
    p params[:subject]
    p params[:"stripped-text"]
    p params[:"body-plain"]

    @user = User.where(email: params[:sender]).first_or_create! do |user|
      user.email = params[:sender]
      user.password = 'temppassword'
    end
    # Find the topic by using params[:subject]

    @topic = Topic.where(title: params[:subject]).first_or_create! do |topic|
      topic.title = params[:subject]
      topic.user_id = @user.id
    end
    # Assign the url to a variable after retreiving it from params["body-plain"]

    # @bookmark = Bookmark.where(url: params["body-plain"]).first_or_create! do |bookmark|
    #   bookmark.url = params["body-plain"]
    #   bookmark.topic_id = @topic.id
    # end

    @bookmark = @topic.bookmarks.build({:url => params[:"stripped-text"]})

    if @bookmark.valid?
      @bookmark.save!
      head 200
    else
      head 400
    end


    # Check if user is nil, if so, create and save a new user

    # Check if the topic is nil, if so, create and save a new topic

    # Now that you're sure you have a valid user and topic, build and save a new bookmark


    # Assuming all went well.
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
