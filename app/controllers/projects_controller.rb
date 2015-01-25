class ProjectsController < ApplicationController

  def index
    # send an instance variable with all project data
    @projects = Project.order(:id)  
  end

  def new
    # send an instance variable of a new (and empty) Project object
    @project = Project.new
  end

  def create 
    # recieve the users inputs as params in a form
    grab_params
    # puts these params into an object called @project
    @project = Project.new grab_params
    if @project.save
      # flash[:notice]="Project saved! "
      redirect_to @project
    else
      # show the form again with error, and use the layout called "special". This will go to the new view in the questions folder. 
      # it's the same as  render "/questions/new"
      render :new  #, layout: "special"  
    end
  end

  def show
    # render text: params
    # send the project object to the show view
    find_project
    # send any existant associated tasks
    @tasks = @project.tasks  # not sure if I need this, just a shortcut?
    # This is a new empty task object so that the user can add a task
    @task = Task.new
  end

  def edit
    # send a project object with the data that already exists
    find_project
  end

  def destroy
    find_project
    @project.destroy
    redirect_to projects_path, notice: "Project deleted successfully!! "
  end

  def update
    find_project
    if @project.update grab_params    #update returns t/f
      redirect_to @project
    else
      render :edit
    end
    # render text: params  #works, reveals all the params
  end

  private

  def grab_params
     # this is the "strong parameters" method to get only the params that we want 
    # and use them. We use the key called "project" from params, and 
    # get the values from it.
    grab_params = params.require(:project).permit(:title, :description)
  end

  def find_project
    # with the id of from the URL, find the object
    @project = Project.find params[:id]
  end
end
