module SearchHelper
  extend ActiveSupport::Concern

  # filter out data from result
  def format_twitter_data(tweets)
    tweets.map { |tweet| {

            "url" => tweet.url.to_s,
            "name" => tweet.user.name,
            "screen_name" => tweet.user.screen_name,
            "text" => tweet.text,
            "created_at" => tweet.created_at,
    }}
  end
end
