class UsersController < ApplicationController
  #load_and_authorize_resource
  skip_authorize_resource :only => [:new, :create]


  
  def show
    @doctor = User.find(params[:id])

  end

end
