class UserActivitiesControllerController < ApplicationController
  before_action :require_login

  def show
    @activities = current_user.user_activities
  end

  private

  def require_login
    redirect_to root_path, notice: "You must be logged in!" unless current_user
  end
end
