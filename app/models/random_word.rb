class RandomWord < ApplicationRecord
  # randomly pick words from random_words table.
  def self.random_word

    self.order("RANDOM()").first.word
  end
end
