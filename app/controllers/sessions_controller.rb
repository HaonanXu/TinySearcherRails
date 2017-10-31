require 'event_loggable'
require 'activity_log/log_handler'

class SessionsController < ApplicationController
  include EventLoggable, LoggableParams

  after_action only: [:create, :destroy] do
    log_event(@user, build_log_params(@event, @status))
  end

  #GET /session
  def new
  end

  #POST /session
  def create
    @user = User.find_by_email(params[:email])
    @event = "LOGIN"
    @status = "SUCCESS"

    if @user && @user.authenticate(params[:password])

      session[:user_id] = @user.id
      redirect_to root_url, notice: "Log In Successfully!"
    else

      @status ="FAILED"
      redirect_to new_session_path, notice: "Email or Password is invalid"
    end
  end

  #DELETE /session
  def destroy
    @user = current_user
    session[:user_id] = nil
    @event = "LOGOUT"
    @status = "SUCCESS"

    redirect_to root_url, notice: "Logged Out"
  end
end
