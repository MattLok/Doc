class DoctorsController < ApplicationController


  def new 
    @doctor = Doctor.new()

  end


end
