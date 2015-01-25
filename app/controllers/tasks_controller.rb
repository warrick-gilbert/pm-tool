class TasksController < ApplicationController
  def new
  end

  def create
    # render text: params  # this is great to see what info is in the form

    # we're going to make a new task and save it to the db. 
    # we need to assemble some info to make a new task. 
    # All the info came from the params, but is provided by two methods.
    @task = Task.new task_params
    find_project_id  # gets the project id for this task, puts it in @project_id
    @task.project = @project_id # puts in the project_id
    # @task.user = current_user # put more info in
    
    if @task.save
      redirect_to @project_id, notice: "Task created successfully! "
      # redirect_to @project_id is the same as:  redirect_to project_path(@project_id) 
    else
      # need to send the user back to show page, but we need to specify 
      # it's from the projects folder, don't look in the tasks folder.
      # @project_id and @task are declared above, these take the info
      # back to the show page
      render "projects/show"
    end
  end

  def show
  end

  def edit

    render text: params  # this is great to see what info is in the form
    # task_params
    @task_to_edit = Task.find params[:id]
    # render text: @task_to_edit.id
    find_project_id
    
  end

  def destroy
    # render text: params  # this is great to see what info is in the form
    find_project_id
    task_to_die = Task.find params[:id]
    task_to_die.destroy
    redirect_to project_path(@project_id), notice: "Task deleted successfully!! "
  end

  def update
  end


private

def task_params
  params.require(:task).permit(:title)
end

def find_project_id
  @project_id = Project.find params[:project_id] # creates an object filled with data
end

end
