require 'activity_log/log_handler'

module ActivityLoggable
  extend ActiveSupport::Concern

  def log_event(event, status, model)

    if model.present?
      LogHandler.new.log(model, {
          "ip" => request.remote_ip,
          "action" =>  {
              event: event,
              status: status
          }
      })
    end
  end
end