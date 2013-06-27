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
      binding.pry

     redirect_to @practice, notice:"Practice Created"
    else
      render 'new'
    end
  end

  def show
    binding.pry
    @practice = Practice.find(params[:id])
  end

end
