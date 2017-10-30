# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
File.open("lib/assets/random_words.txt", 'r') do |f|
  f.each_line do |line|
    RandomWord.create({"word" => line.gsub("\n", "").strip}) if line.gsub("\n", "").strip.present?
  end
end