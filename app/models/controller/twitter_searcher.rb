require 'controller/searcher'

class TwitterSearcher < Searcher
  def search
    raise ArgumentError, 'Empty Key Words !' if @key_words.blank?

    client = Twitter::REST::Client.new(credentials['TWITTER'])
    client.search(@key_words).take(10)
  end
end