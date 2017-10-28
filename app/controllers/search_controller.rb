require 'twitter'
class SearchController < ApplicationController
  def index
  end

  #GET /search/show
  def show
    tweets_search(params[:key_words])
  end

  private
    def tweets_search(key_words)
      config = {
          consumer_key: "1SWsuwC2hr4pvV3KeMyodBhNr",
          consumer_secret: "8d85nrJzjZbQIisIsiPC9eoGHhJq19muaY6Csg8BFyKLtNjxYF",
      }
      client = Twitter::REST::Client.new(config)
      @tweets = client.search(key_words).take(10)
    end
end
