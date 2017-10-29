require 'activity_log/user_activity_logger'

class LogHandler

  def initialize
    @user_activity_logger = UserActivityLogger.new
  end

  def log(model, activities)
    @user_activity_logger.log(model, activities)
  end
end