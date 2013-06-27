class HomeController < ApplicationController
  skip_before_filter :check_user_has_practice!
end
