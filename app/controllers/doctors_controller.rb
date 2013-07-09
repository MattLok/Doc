class DoctorsController < ApplicationController
  #load_and_authorize_resource

  def show
    @doctor = User.find(params[:id])
  end

end
