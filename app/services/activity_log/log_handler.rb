require 'activity_log/user_activity_logger'
require 'activity_log/error_logger'

class LogHandler

  def initialize
    @user_activity_logger = UserActivityLogger.new ErrorLogger.new
  end

  def log(model, activities = nil)
    @user_activity_logger.log(model, activities)
  end
end