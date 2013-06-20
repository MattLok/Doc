class DoctorsController < ApplicationController


  # def new 
  #   @doctor = Doctor.new()

  # end

  def show
    @doctor = User.find(params[:id])

  end


end
