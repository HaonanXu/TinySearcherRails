class CreateSystemLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :system_logs do |t|
      t.string "event"
      t.string "message", null: true
      t.json "log", null: true, default: {}

      t.timestamps
    end
  end
end
