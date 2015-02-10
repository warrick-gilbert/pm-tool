class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def new
  end

  def create
    # render text: params  # this is great to see what info is in the form

    # we're going to make a new task and save it to the db. 
    # we need to assemble some info to make a new task. 
    # All the info came from the params, but is provided by two methods.
    @task = Task.new task_title_params
    @task.user = current_user
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

  # def show
  #   # render text: stopped!
  #   # @project.do_something
  # end

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
    task_to_die = current_user.tasks.find params[:id]
    task_to_die.destroy
    redirect_to project_path(@project), notice: "Task deleted successfully!! "
  end

  def update
    @task = Task.find params[:id]    
    # Need If else statement to sniff out which update tasks are 
    # to toggle the done/undone, and which are to add a new task

    if task_toggle_params[:done].to_s == "" 
      # updating the task text
      @task.update task_title_params
    else
      # toggling the done/undone status
      task_owner = User.find(@task.user_id)  
      @task.update task_toggle_params
      # render text: task_params[:done] + @task.user.id.to_s + " " + task_owner.id.to_s + " " + params[:id]
      # if someone other than the task owner completes the task, 
      # send email to task owner
      if current_user!= task_owner
        @task.user = current_user
        AnswersMailer.notify_task_owner(@task).deliver_later
      end
    end
    find_project
    redirect_to project_path(@project), notice: "Task updated successfully!! "
  end

  private

  def task_title_params
  params.require(:task).permit(:title)
  end

  def task_toggle_params
  params.require(:task).permit(:done) 
  end

  def find_project
    @project = Project.find params[:project_id] # creates an object filled with data
    redirect_to root_path, alert: "Access Denied" if current_user.blank?
  end

end
