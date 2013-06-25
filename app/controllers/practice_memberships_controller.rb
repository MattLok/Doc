class PracticeMembershipsController < ApplicationController
  load_and_authorize_resource


  def create
    @patient = Patient.find(params[:patient_id])
    @practice = Practice.find(params[:practice_id])

    @practice_membership = PracticeMembership.new()
    @practice_membership.patient_id = @patient
    @practice_membership.practice_id = @practice 
    @practice_membership.save

  end

end
