class TasksController < ApplicationController
  def new
  end

  def create
    # render text: params  # this is great to see what info is in the form

    # we're going to make a new task and save it to the db. 
    # we need to assemble some info to make a new task. 
    # All the info came from the params, but is provided by two methods.
    @task = Task.new task_params
    find_project  # gets the project id for this task, puts it in @project
    @task.project = @project # puts in the project
    # @task.user = current_user # put more info in
    
    # debugger

    if @task.save
      redirect_to @project, notice: "Task created successfully! "
      # redirect_to @project is the same as:  redirect_to project_path(@project) 
    else
      # need to send the user back to show page, but we need to specify 
      # it's from the projects folder, don't look in the tasks folder.
      # @project and @task are declared above, these take the info
      # back to the show page
      @tasks = @project.tasks
      render "projects/show"
    end
  end

  def show
  end

  def edit

    # render text: params[:project]  # this is great to see what info is in the form
    find_project
    @task_to_edit = Task.find params[:id]
    # @task_to_edit.project = params[:project]
    # render text: @task_to_edit.id

  end

  def destroy
    # render text: params  # this is great to see what info is in the form
    find_project
    task_to_die = Task.find params[:id]
    task_to_die.destroy
    redirect_to project_path(@project), notice: "Task deleted successfully!! "
  end

  def update
    # render text: params
    @task = Task.find params[:id]
    @task.update title: task_params[:title]
    # # render text: task_params[:title]
    find_project
    redirect_to project_path(@project), notice: "Task updated successfully!! "
  end


  private

  def task_params
    params.require(:task).permit(:title)  # removed , :id, :project_id
    # params1 = params.require(:task).permit(:title)
    # params2 = params.permit(:project_id, :id)
    # params1.merge(params2)    # returns more good strong params from params
  end

  def find_project
    @project = Project.find params[:project_id] # creates an object filled with data
  end

end
