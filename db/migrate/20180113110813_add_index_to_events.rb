class AddIndexToEvents < ActiveRecord::Migration[5.1]
  def change
    add_index :events, :calendar_id, :unique => true
  end
end
