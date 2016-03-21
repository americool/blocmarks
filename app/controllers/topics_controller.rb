class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @user = current_user

    @topic = Topic.new(topic_params)
    @topic.user_id = @user.id 
        if @topic.save
          flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
          redirect_to action: :index
        else
          flash.now[:alert] = "Error creating topic. Please try again"
          render :new
        end
  end

  def edit
  end

  def destroy
    @topic = Topic.find(params[:id])

      if @topic.destroy
        flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
        redirect_to action: :index
      else
        flash.now[:alert] = "There was an error deleteing the topic."
        render :show
    end
  end

  private
    def topic_params
        params.require(:topic).permit(:title)
    end
end
