class DiscussionsController < ApplicationController
  def create
    grab_params

    # render text: grab_params

    # make the new discussion object and populate it with the title and description
    @discussion = Discussion.new grab_params
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

      redirect_to project_path(@project)
    end

  end

  def destroy
  end

  private

  def grab_params
    params1 = params.require(:discussion).permit(:title, :description)
    params2 = params.permit(:project_id)
    params1.merge(params2)    # returns more good strong params from params
  end

  def find_project
     Project.find grab_params[:project_id] # creates an object filled with data
     
  end
end
