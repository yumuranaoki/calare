class AddIndexToGroups < ActiveRecord::Migration[5.1]
  def change
    add_index :groups, :access_id, :unique => true
  end
end
