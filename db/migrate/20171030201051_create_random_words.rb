class CreateRandomWords < ActiveRecord::Migration[5.1]
  def change
    create_table :random_words do |t|
      t.string "word"

      t.timestamps
    end
  end
end
