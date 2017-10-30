module LoggableParams
  extend ActiveSupport::Concern

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