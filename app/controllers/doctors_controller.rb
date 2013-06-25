class DoctorsController < ApplicationController
  #load_and_authorize_resource


  # def new 
  #   @doctor = Doctor.new()

  # end

  def show
    @doctor = User.find(params[:id])

  end


end
