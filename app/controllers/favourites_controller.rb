class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    # render text: params
    @project = Project.find params[:project_id]


    @favourite = @project.favourites.new 
    @favourite.user = current_user
    # @favourite.project = project
    @favourite.save
    redirect_to project_path(@project), notice: "Favourited!"
  end


  def destroy
      # render text: params
      project = Project.find params[:project_id]
      favourite = Favourite.find params[:id]
      favourite.destroy
      redirect_to project_path(project), notice: "Unfavourited!"
  end
end
