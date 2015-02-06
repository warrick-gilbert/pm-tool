class DiscussionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def create
    grab_params

    # render text: grab_params

    # make the new discussion object and populate it with the title and description
    @discussion = Discussion.new grab_params
    @discussion.user = current_user
    # @d.project_id = @project.id
    # render text: @d.project.title
    # render text:  @d.project_id

    if @discussion.save
      redirect_to @project, notice: "Discussion created successfully! "
    else
      @project = find_project
      @tasks = @project.tasks
      # render project_path(@project.id)
      # render text: project_path(@project.id)

      redirect_to project_path(@project), notice: "Discussion deleted successfully!! "
    end
  end

  def edit
    # render text: params
    find_project
    @discussion = Discussion.find params[:id]
  end

  def update
    grab_params
    @discussion = Discussion.find params[:id]
    # render text: @discussion.description
    @discussion.update title: grab_params[:title]
    @discussion.update description: grab_params[:description]
    find_project
    redirect_to project_path(@project), notice: "Discussion updated successfully!! "
    
  end

  def destroy
    # render text: params
    find_project
    discussion_to_die = current_user.discussions.find params[:id]
    # render text:discussion_to_die.id

    discussion_to_die.destroy
    redirect_to project_path(@project)
  end

  private

  def grab_params
    params.require(:discussion).permit(:title, :description)
  end

  def find_project
     @project = Project.find params[:project_id] # creates an object filled with data
     
  end
end
