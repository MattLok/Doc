class PatientsController < ApplicationController


  def new
    @patient = Patient.new(params[:practice_id])

  end


end
