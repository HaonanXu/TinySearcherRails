require 'event_loggable'
require 'search/searcher'
require 'twitter'

class SearchController < ApplicationController
  include EventLoggable, LoggableParams, SearchHelper

  before_action :load_config
  after_action only: [:show, :show_random] do
    log_event(current_user, build_log_params("SEARCH", @status))
  end

  def index
    @options = @permitted_sites.to_a
  end

  #GET /search/show
  def show
    @status = "SUCCESS"

    begin
      if have_keywords

        @results = Searcher.new.search params[:site], params[:key_words]
      else

        @status = "FAILED"
        redirect_to search_index_path, notice: "Please type in some keywords..."
      end
    rescue Twitter::Error, ArgumentError, RuntimeError => e

      @status = "FAILED"
      redirect_to search_index_path, notice: e.message
    end
  end

  #GET /search/random
  # Only enabled for TWITTER since LCBO and Weather search are not implemented yet.
  def show_random
    @status = "SUCCESS"

    begin

      redis = Redis.new(host: ENV.fetch('REDIS_HOST', 'localhost'))
      key_word = RandomWord.random_word

      if redis.get key_word

        @results = JSON.load(redis.get (key_word).gsub('\"','"'))
      else

        @results = Searcher.new.search "TWITTER", key_word
        @results = format_twitter_data (@results)
        redis.set(key_word, @results.to_json)
      end

      render "show"
    rescue Twitter::Error, ArgumentError, RuntimeError => e

      @status = "FAILED"
      redirect_to search_index_path, notice: e.message
    end
  end

  private

  # check if key_words is provided on regular search.
  def have_keywords

    params[:key_words].present?
  end

  # load supported sites for search from cinfig file.
  def load_config

    @permitted_sites = Rails.configuration.searcher['supported_sites']
  end
end
