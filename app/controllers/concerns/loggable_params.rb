module LoggableParams
  extend ActiveSupport::Concern

  # Build log params for loggable enabled classes
  def build_log_params(event, status)
    @params = {
        "ip" => request.remote_ip,
        "action" => {
            event: event,
            status: status
        }
    }
  end
end