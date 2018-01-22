class AddMultiToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :multi, :boolean
  end
end
