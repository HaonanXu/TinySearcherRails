require 'twitter'
require 'search/searcher'
require 'event_loggable'

class SearchController < ApplicationController
  include EventLoggable, LoggableParams

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

  # Eabled for TWITTER only.
  def show_random
    @status = "SUCCESS"

    begin
      @results = Searcher.new.search "TWITTER", random_word
      render "show"

    rescue Twitter::Error, ArgumentError, RuntimeError => e
      @status = "FAILED"
      redirect_to search_index_path, notice: e.message
    end
  end

  private

  def have_keywords
    params[:key_words].present?
  end

  def random_word
    RandomWord.order("RANDOM()").first.word
  end

  def load_config
    @permitted_sites = Rails.configuration.searcher['supported_sites']
  end
end
