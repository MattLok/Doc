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
    @referrals = @practice.referrals
    @received_referrals = @practice.received_referrals

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

  def hash_fix(thing)
    h = {}
    thing.each{|k,v| h[DateTime.parse(k).strftime("%B")] = v }
    h
  end
end
