require 'twitter'
require 'search/searcher'

class SearchController < ApplicationController
  before_action :load_config

  def index
    @options = @permitted_sites.to_a
  end

  #GET /search/show
  def show
    begin
      if have_keywords
          Searcher.new.search params[:site]
      else
        flash.now.alert = "Please type in some keywords..."
        redirect_to search_index_path
      end
    rescue Twitter::Error, ArgumentError, RuntimeError => e
      flash.now.alert = e.message
      redirect_to search_index_path
    end
  end

  private

  def have_keywords
    params[:key_words].present?
  end

  def load_config
    @permitted_sites = Rails.configuration.searcher['supported_sites']
  end
end
