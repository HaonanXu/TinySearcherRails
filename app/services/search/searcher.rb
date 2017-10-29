require 'search/twitter_searcher'

class Searcher
  def search(gate_way)
    @permitted_sites = Rails.configuration.searcher['supported_sites']

    case gate_way
      when @permitted_sites["Twitter"]
        @results = TwitterSearcher.new(params[:key_words]).search
      when @permitted_sites["LCBO"]
        raise RuntimeError, "Still in developing and coming soon ..."
      when @permitted_sites["Weather"]
        raise RuntimeError, "Still in developing and coming soon ..."
      else
        raise ArgumentError, "Unsupported site!"
    end
  end
end