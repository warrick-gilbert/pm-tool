class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    # render text: params
    find_project
    # render text: @project
    favourite = @project.favourites.new 
    favourite.user = current_user
    # @favourite.project = project
    favourite.save
    redirect_to project_path(@project), notice: "Favourited!"
  end


  def destroy
    # render text: params
    find_project
    favourite = Favourite.find params[:id]
    favourite.destroy
    redirect_to project_path(@project), notice: "Unfavourited!"
  end

  private

  def find_project
    @project = Project.find params[:project_id]
  end
end
