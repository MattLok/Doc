class AppointmentsController < ApplicationController
  load_and_authorize_resource

  def new

    @practice = Practice.find(params[:practice_id])
    @appointment = @practice.appointments.build()
    @doctors = @practice.users
    @patients = @practice.patients

  end


  def create
    @practice = Practice.find(params[:practice_id])
    @patient = Patient.find(params[:appointment][:prac_mem_id])

    if @patient.practice_memberships.pluck(:practice_id).include?(params[:practice_id].to_i)
      @membership = PracticeMembership.where(:practice_id =>@practice.id, :patient_id => @patient.id ).first
      @appointment.date = "#{params[:appointment]["date(1i)"]}/#{params[:appointment]["date(2i)"]}/#{params[:appointment]["date(3i)"]}"
      @appointment.prac_mem_id = @membership.id
    else
      @membership = PracticeMembership.create!(:practice_id => @practice.id,:patient_id => @patient.id)
      @appointment.date = "#{params[:appointment]["date(1i)"]}/#{params[:appointment]["date(2i)"]}/#{params[:appointment]["date(3i)"]}"
      @appointment.prac_mem_id = @membership.id
    end

    if @appointment.save
      redirect_to @practice, notice:"Appointment Created"
    else
      render(action:'new')
    end

  end

  def index

    @practice = current_user.practice
    if current_user.role == 'practice_admin'
      @appointments = @practice.appointments.where("user_id IS NOT NULL")
    else
      @appointments = current_user.appointments
    end
    @appointment = @practice.appointments.build(params[:appointment])
    @doctors = @practice.users
    @patients = @practice.all_patients
    #@options = [@practice.patients,@practice.received_referrals]


  end



end
