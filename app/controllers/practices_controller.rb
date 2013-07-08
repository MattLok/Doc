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

    @sent = sent_monthly_referrals
    @stats = {
              most_sent_referrals: @practice.most_sent_referrals,
              most_received_referrals: @practice.most_received_referrals,
              most_inbound_referrals: @practice.most_inbound,
              referral_appointments: @practice.referral_appointments(@practice.received_referrals),
              referral_to_appointment_percent: @practice.referral_to_appointment_percent(@practice.received_referrals),
              sent_referral_to_appointment_percent: @practice.referral_to_appointment_percent(@practice.referrals)
    }
  end

  protected


  def senders
    User.find(@practice.received_referrals.pluck(:user_id))
  end

  def monthly_referrals
    data = senders.map do |sender|
      {:name => sender.practice.office_name, :data => hash_fix(sender.referrals.group_by_month(:created_at).count) }
    end

    # senders.first.referrals.group_by_month(:created_at).count.each{|k,v| h[DateTime.parse(k).strftime("%B")] = v }
    # binding.pry
  end

  def receivers
    User.find(@practice.referrals.pluck(:to_user))
  end

  #gets all referrals for receivers, not just the ones from the practice we want #Referral.sent_to_other_practice(receiver.practice
  def sent_monthly_referrals
    data = receivers.map do |receiver|
      {:name => receiver.practice.office_name, :data => hash_fix(receiver.received_referrals_from(@practice).group_by_month(:created_at).count) }
    end
    binding.pry
  end

  def hash_fix(thing)
    h = {}
    thing.each do |k,v|
      h[DateTime.parse(k).strftime("%B")] = v
    end
    h
  end


end
