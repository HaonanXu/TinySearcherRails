class CreateUserActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :user_activities do |t|
      t.integer "user_id", null: false
      t.string "ip"
      t.jsonb "action", null: false, default: {}

      t.timestamps
    end
  end
end
