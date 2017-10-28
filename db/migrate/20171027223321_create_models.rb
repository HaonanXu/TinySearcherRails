class CreateModels < ActiveRecord::Migration[5.1]
  def change
    create_table :models do |t|
      t.string :User
      t.string :name
      t.string :eamil
      t.string :password

      t.timestamps
    end
  end
end
