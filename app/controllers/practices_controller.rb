class PracticesController < ApplicationController


  def new
    @practice = Practice.new()
  end

  def show
    @practice = Practice.find(params[:id])
  end

end
