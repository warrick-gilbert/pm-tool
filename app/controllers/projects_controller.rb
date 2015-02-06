class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    # if the search term exists
    if params[:search_term]
      # grab_params  # REDUNDENT
      search_term = "\%" + @search_term + "\%"
      # send an instance variable with the project data that matches the search, order it by :id
      @projects = Project.all.where("title ILIKE ? OR description LIKE ?", search_term, search_term).order(:id)  
    else
      # send an instance variable with all project data
      @projects = Project.order(:id)  
    end
  end

  def new
    # send an instance variable of a new (and empty) Project object
    @project = Project.new
  end

  def create 

    # recieve the users inputs as params in a form
    # grab_params  # REDUNDENT
    # puts these params into an object called @project
    @project = Project.new grab_params
    @project.user = current_user
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
    # debugger
    # render text: params
    # send the project object to the show view
    find_project
    # send any existant associated tasks
    @tasks = @project.tasks  # array-like-thing ActiveRecord Relation

    # debugger


    
    # This is a new empty task object so that the user can add a task
    @task = Task.new
    @discussion = Discussion.new
    # debugger
  end

  def edit
    # send a project object with the data that already exists
    find_project
  end

  def destroy
    find_project
      if @project.user == current_user && @project.destroy
        redirect_to projects_path, notice: "Project deleted successfully!! "
      else
        redirect_to projects_path, error: "Whoops, your project was not successfully deleted. "
      end
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
    if params[:search_term]  # REDUNDENT
      @search_term = params[:search_term]  # REDUNDENT
    else
       # this is the "strong parameters" method to get only the params that we want 
      # and use them. We use the key called "project" from params, and 
      # get the values from it.
      grab_params = params.require(:project).permit(:title, :description, :due_date) 
      # + params.require().permit(:commit, :search_term)
    end
  end

  def find_project
    # with the id of from the URL, find the object
    # @project = Project.find params[:id]
    @project = current_user.projects.find_by_id(params[:id])
    redirect_to root_path, alert: "Access Denied" unless @project
  end
end
