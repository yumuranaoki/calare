class AddAccessIdToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :access_id, :string
  end
end
