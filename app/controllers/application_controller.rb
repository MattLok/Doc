class ApplicationController < ActionController::Base
  protect_from_forgery
  #check_authorization :unless => :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_filter :check_user_has_practice!

  def check_user_has_practice! 
    if signed_in?
      #binding.pry

      unless current_user.has_practice?
        redirect_to new_practice_path
        false
      end
    end
  end

end
