class AddFinishedToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :finished, :boolean, default: false
  end
end
