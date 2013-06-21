class ReferralsController < ApplicationController


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
      redirect_to doctor_path(@doctor), notice: "Referral Sent"
    else
      render(action:'new')
    end

  end



end
