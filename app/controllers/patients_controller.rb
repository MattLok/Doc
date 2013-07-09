class PatientsController < ApplicationController
  load_and_authorize_resource

  def new
    @practice = Practice.find(params[:practice_id])
    @patient = @practice.patients.build()

  end

  def create
    @practice = Practice.find(params[:practice_id])
    @patient = @practice.patients.new(params[:patient])
    @patient.save
    @practice_membership = PracticeMembership.create!(:patient_id => @patient.id, :practice_id => @practice.id)#@practice, @patient)
    if @practice_membership.save
      redirect_to @practice, notice:"Patient Successfully Created"
    else
      render(action: 'new')
    end
  end

  def show
    @patient = current_user.practice.patients.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @practice = current_user.practice
    if current_user.role == 'practice_admin'
      @patients = @practice.patients.where("patients.id IS NOT NULL")
    else
      @patients = current_user.patients.where("id IS NOT NULL")
    end
    @patient = @practice.patients.build()
  end

end
