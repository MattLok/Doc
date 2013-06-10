class PracticesController < ApplicationController


  def new
    @practice = Practice.new()

    if @practice.save
      notice:""
    end
  end

  def create
    @practice = Practice.new(params[:practice])

  end

  def show
    @practice = Practice.find(params[:id])
  end

end
