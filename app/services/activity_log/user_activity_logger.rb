require 'activity_log/loggable'

class UserActivityLogger < Loggable

  def log(model, activities)
    if model.is_a? User

      log_activities(model, activities)
    elsif @successor.is_a? Loggable

      @successor.log(model, activities)
    else

      raise ArgumentError, 'No supported Logger !'
    end
  end

  private

  def log_activities(model, activities)

    raise ArgumentError, 'Missing Data !' if model.blank? or activities.blank?

    UserActivity.create({
        "user_id" => model.id,
        "ip" => activities['ip'],
        "action" => activities['action']})
  end
end