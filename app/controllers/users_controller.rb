class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @favourites = current_user.favourites
    # render text: @favourites
    @ffavourites = current_user.find_favourites
  end
end
