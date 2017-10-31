require 'event_loggable'

class UsersController < ApplicationController
  include EventLoggable, LoggableParams

  before_action :set_user, only: [:update, :destroy]
  after_action only: [:create, :update] do
    log_event(@user, build_log_params(@event, @status))
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      @event = "REGISTER"
      @status = "SUCCESS"

      redirect_to search_index_path, notice: "You have successfully signed up."
    else
      redirect_to new_user_path, notice: "Sorry, sign up failed, Please try again..."
    end
  end

  #GET /users/:id
  def edit
    redirect_to root_path, notice: "You must be logged in!" unless current_user
  end

  # PATCH/PUT /users/:id
  def update
    @event = "RESET_PASSWORD"
    @status = "SUCCESS"

    if @user.update(user_params.select{|key, value| ["password", "password_confirmation"].include?(key)})
      redirect_to search_index_path, notice: "Password was successfully changed."
    else
      @status ="FAILED"
      redirect_to edit_user_path, notice: "Change Password Failed..."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
