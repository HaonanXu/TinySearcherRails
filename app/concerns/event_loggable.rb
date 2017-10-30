require 'activity_log/log_handler'

module EventLoggable
  extend ActiveSupport::Concern

  def log_event(model, params = nil)

    if model.present?
      LogHandler.new.log(model, params)
    end
  end
end