require 'event_loggable'
require 'activity_log/log_handler'

class SessionsController < ApplicationController
  include EventLoggable, LoggableParams

  after_action only: [:create, :destory] do
    log_event(@user, build_log_params(@event, @status))
  end

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    @event = "LOGIN"
    @status = "SUCCESS"

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Log In Successfully!"
    else
      @status ="FAILED"
      flash.now.alert = "Email or Password is invalid"
      render "new"
    end
  end

  def destroy
    @user = current_user
    session[:user_id] = nil
    @event = "LOGOUT"
    @status = "SUCCESS"
    redirect_to root_url, notice: "Logged Out"
  end
end
