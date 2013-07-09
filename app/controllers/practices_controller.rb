class PracticesController < ApplicationController
  load_and_authorize_resource
   #skip_authorize_resource :only => [:new, :create]
   skip_before_filter :check_user_has_practice!, :only =>[:new,:create,:show]

   helper_method :monthly_referrals

  def new
    @practice = Practice.new()
  end

  def create
    @practice = Practice.new(params[:practice])
    @user = current_user
    if @practice.save
      @user.practice_id = @practice.id
      @user.make_admin
      @user.save

     redirect_to @practice, notice:"Practice Created"
    else
      render 'new'
    end
  end

  def show
    @practice = current_user.practice
    @sent = @practice.sent_monthly_referrals
    @received = @practice.monthly_referrals
    @stats = {
      most_sent_referrals: @practice.most_sent_referrals,
      most_received_referrals: @practice.most_received_referrals,
      most_inbound_referrals: @practice.most_inbound,
      referral_appointments: @practice.referral_appointments(@practice.received_referrals),
      referral_to_appointment_percent: @practice.referral_to_appointment_percent(@practice.received_referrals),
      sent_referral_to_appointment_percent: @practice.referral_to_appointment_percent(@practice.referrals)
    }
  end


end
