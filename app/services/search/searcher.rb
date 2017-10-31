require 'search/twitter_searcher'
require 'event_loggable'

# A gateway implementation for all Apis be used for searching
# currently only implemented Twitter. LCBO and Weather could also extend the searchable abstract class
# and implement search function, and get enabled in here.
class Searcher
  include EventLoggable

  # The search api geteway
  # Encapsulate all third party search Apis here
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
        log_event(@error)
        raise @error
      else

        @error = ArgumentError.new "Unsupported site!"
        log_event(@error)
        raise @error
    end
  end
end