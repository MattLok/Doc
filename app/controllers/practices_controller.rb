class PracticesController < ApplicationController
  load_and_authorize_resource
   #skip_authorize_resource :only => [:new, :create]
   skip_before_filter :check_user_has_practice!, :only =>[:new,:create,:show]

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

    respond_to do |format|
      format.html
      #format.json {render json: @referrals.to_json(:include => { :user => { :only => :practice_id}})}
      #format.json {render json: @referrals.to_json(:methods => :recipient, :include => { :user => { :include => {:practice => {:only => :office_name} }}})}

      format.json {
        render :json => {
          :referrals => @referrals.as_json(:methods =>:recipient,
            :include => {
              :user => {
               :include => {
                :practice => {
                  :only => :office_name} }}}),
          :received_referrals => @received_referrals.as_json(:methods => :sender,
            :include => {
              :user => {
                :include => {
                  :practice => {
                    :only => :office_name} }}})
      }
    }

    end

  end

end
