class AppointmentsController < ApplicationController
  load_and_authorize_resource

  def new

    @practice = Practice.find(params[:practice_id])
    @appointment = @practice.appointments.build()
    @doctors = @practice.users
    @patients = @practice.patients

  end


  def create
    #binding.pry
    @practice = Practice.find(params[:practice_id])
    @patient = PracticeMembership.find(params[:appointment][:prac_mem_id]).patient
    @doctor = User.find(params[:appointment][:user_id])
    @appointment = @practice.appointments.new(params[:appointment])

    @practice_membership = PracticeMembership.where(:practice_id =>@practice.id, :patient_id => @patient.id ).first
    @appointment.prac_mem_id = @practice_membership.id

    if @appointment.save
      redirect_to @practice, notice:"Appointment Created"
    else
      render(action:'new')
    end

  end



end
