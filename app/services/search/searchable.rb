class Searchable
  def initialize(key_words)
    @key_words = key_words
  end

  def search
    raise NotImplementedError, 'Subclass has to implement this function'
  end

  def credentials
    Rails.configuration.searcher['api_credentials']
  end
end