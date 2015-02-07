class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def create
    find_discussion
    # render text: @project.id
    @comment = Comment.new grab_params
    @comment.user = current_user
    @comment.discussion_id = params[:discussion_id]
    if @comment.save 
      redirect_to @project, notice: "Comment created successfully."
    else
      redirect_to @project, notice: "Nope, there was a problem with saving your comment. "
    end
  end

  private

  def find_discussion
    @discussion = Discussion.find params[:discussion_id]
    @project = Project.find @discussion.project_id
    redirect_to root_path, alert: "Access Denied" if current_user.blank?
  end

  def grab_params
    grab_params = params.require(:comment).permit(:body, :discussion_id) 
  end

end
