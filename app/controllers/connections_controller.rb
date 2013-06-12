class ConnectionsController < ApplicationController

  def new 

    #binding.pry
    @practice = Practice.find(params[:practice_id])
    @all_pracs = Practice.all 
    @connection = Connection.new()


  end

  def create 
    binding.pry
    @practice = Practice.find(params[:practice_id])
    @target = Practice.find(params[:connection][:target_id])

    @connection = Connection.create(:requestor_id => @practice.id, :target_id => @target.id)

    if @connection.save
      redirect_to @practice, notice: "Connection Request Sent"
    else
      render(action: 'new')
    end


  end


end
