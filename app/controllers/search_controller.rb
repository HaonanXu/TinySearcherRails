require 'twitter'
require 'controller/twitter_searcher'

class SearchController < ApplicationController
  before_action :load_config

  def index
    @options = @permitted_sites.to_a
  end

  #GET /search/show
  def show
    if have_keywords
      search
    else
      flash.now.alert = "Please type in some keywords..."
      redirect_to search_index_path
    end
  end

  private

  def search
    begin
      case params[:site]
        when @permitted_sites["Twitter"]
          @results = TwitterSearcher.new(params[:key_words]).search
        when @permitted_sites["LCBO"]
          puts "LCBO"
        when @permitted_sites["Weather"]
          puts "Weather"
        else
          raise ArgumentError, "Unsupported site!"
      end
    rescue Twitter::Error, ArgumentError => e
      flash.now.alert = e.message
      redirect_to search_index_path
    end
  end

  def have_keywords
    params[:key_words].present?
  end

  def load_config
    @permitted_sites = Rails.configuration.searcher['supported_sites']
  end
end
