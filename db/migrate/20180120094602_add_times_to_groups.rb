class AddTimesToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :determined_start, :string
    add_column :groups, :determined_end, :string
  end
end
