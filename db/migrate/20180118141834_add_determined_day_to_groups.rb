class AddDeterminedDayToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :determined_day, :date
  end
end
