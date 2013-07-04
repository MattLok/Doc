class PatientsController < ApplicationController
  load_and_authorize_resource

  def new
    @practice = Practice.find(params[:practice_id])
    @patient = @practice.patients.build()
   # @practice_membership = PracticeMembership.new(params[@patient,:practice_id])
    #if @patient.save
     # binding.pry
      #@practice_membership.create(params[@patient])
    #end

  end

  def create
    @practice = Practice.find(params[:practice_id])
    @patient = @practice.patients.new(params[:patient])
    #@practice.save
    @patient.save
    @practice_membership = PracticeMembership.create!(:patient_id => @patient.id, :practice_id => @practice.id)#@practice, @patient)
    if @practice_membership.save

      redirect_to @practice, notice:"Patient Successfully Created"

    else
      render(action: 'new')

    end
  end

  def index
    @practice = current_user.practice
    @patients = @practice.patients

    @patient = @practice.patients.build()


  end


end
