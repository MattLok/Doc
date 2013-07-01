class ReferralsController < ApplicationController
  load_and_authorize_resource


  def new     
    @doctor = User.find(params[:doctor_id])
    @referral = @doctor.referrals.build()
    #@practice = Practice.find(@doctor.practice_id)
    @potential = User.all
    @patients = Patient.all
    @connected_docs = @referral.connected_docs 
    #binding.pry
    #@doc_patient
  end

  def create
    @doctor = User.find(params[:doctor_id])
    @to_doc = User.find(params[:referral][:to_user])
    @patient = Patient.find(params[:referral][:patient_id])
    @referral = @doctor.referrals.build(:to_user => @to_doc.id,
                                        :patient_id => @patient.id,
                                        :notes => params[:referral][:notes])
    #binding.pry

    if @referral.save 
      redirect_to practice_path(@doctor.practice), notice: "Referral Sent"
    else
      render(action:'new')
    end

  end

  def show
    @referral = Referral.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end

  end

  def index
    
    @practice = current_user.practice
    if current_user.role == 'practice_admin'
      @referrals = @practice.referrals.where("user_id IS NOT NULL")
      @received = @practice.received_referrals
    else
      @referrals = current_user.referrals.where("user_id IS NOT NULL")
      @received = current_user.received_referrals

    end 
    @doctor = current_user
    @referral = @doctor.referrals.build(params[:referral])
    @patients = @practice.patients
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: [@referrals,@received]}
    end
   # binding.pry
  end



end
