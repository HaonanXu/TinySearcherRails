require 'search/twitter_searcher'
require 'event_loggable'

class Searcher
  include EventLoggable

  def search(gate_way, key_words)
    @permitted_sites = Rails.configuration.searcher['supported_sites']

    case gate_way
      when @permitted_sites["Twitter"]
        @results = TwitterSearcher.new(key_words).search
      when @permitted_sites["LCBO"]
        @error = RuntimeError.new "LCBO search is still in developing and coming soon ..."
        log_event(@error)
        raise @error
      when @permitted_sites["Weather"]
        @error = RuntimeError.new "Weahter search is still in developing and coming soon ..."
        raise @error
      else
        @error = ArgumentError.new "Unsupported site!"
        raise @error
    end
  end
end