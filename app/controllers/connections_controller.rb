class ConnectionsController < ApplicationController
  load_and_authorize_resource

  def new

    @practice = Practice.find(params[:practice_id])
    @all_pracs = @practice.potential_connections
    @connection = Connection.new()

  end

  def create
    @practice = Practice.find(params[:practice_id])
    @target = Practice.find(params[:connection][:target_id])
    @connection = Connection.create(:requestor_id => @practice.id, :target_id => @target.id)
    if @connection.save
      redirect_to @practice, notice: "Connection Request Sent"
    else
      render(action: 'new')
    end
  end

  def index
    @practice = current_user.practice
    @connections = Connection.where("target_id = ?", @practice.id).where(:status_type => "Pending")
    @connection = Connection.new(params[:connection])
    @all_pracs = @practice.potential_connections
    @accepted_connections = @practice.accepted_connections
  end

  def update
    @practice = Practice.find(params[:practice_id])
    @connection = Connection.find(params[:id])
    if (params[:accept_connection])
      @connection.status_type = "Accepted"
      flash[:notice] = "You are now connected"
    elsif (params[:decline_connection])
      @connection.status_type = "Declined"
      flash[:notice] = "You rejected them..."
    end

    @connection.save
    redirect_to @practice
  end

end
