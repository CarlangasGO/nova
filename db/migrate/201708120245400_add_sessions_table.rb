class AddSessionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.timestamps
      t.string :session_id, :null => false
      t.text :data
    end

    add_index :sessions, :session_id, :unique => true
    add_index :sessions, :updated_at
  end
end
