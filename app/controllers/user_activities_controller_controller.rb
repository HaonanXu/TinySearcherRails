class UserActivitiesControllerController < ApplicationController
  before_action :require_login

  def show
    @activities = current_user.user_activities
  end

  private

  def require_login
    if current_user.blank?
      flash.now.alert = "You must be logged in!"
      redirect_to root_path unless current_user
    end
  end
end
