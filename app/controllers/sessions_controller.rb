require 'activity_log/log_handler'

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      LogHandler.new.log(user, {
          "ip" => request.remote_ip,
          "action" =>  {
              event: "LOGIN"
          }
      })

      redirect_to root_url, notice: "Log In Successfully!"
    else
      flash.now.alert = "Email or Password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged Out"
  end
end
