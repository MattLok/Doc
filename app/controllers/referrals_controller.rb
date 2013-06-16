class ReferralsController < ApplicationController


  def new 
    
    @doctor = Doctor.find(params[:doctor_id])
    @referral = @doctor.referrals.build()
    @practice = Practice.find(@doctor.practice_id)
    @potential = Doctor.all
    @patients = Patient.all 
    binding.pry
    #@doc_patient

  end
end
