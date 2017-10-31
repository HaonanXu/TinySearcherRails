require 'activity_log/loggable'

class ErrorLogger < Loggable
  def log(model, activities = nil)
    if model.is_a? Exception
      SystemLog.create({
                              "event" => model.class.name,
                              "message" => model.message,
                              "log" => model.as_json
                       })
    elsif @successor.is_a? Loggable
      @successor.log(model, activities)
    else
      raise ArgumentError, 'No supported Logger !'
    end
  end
end