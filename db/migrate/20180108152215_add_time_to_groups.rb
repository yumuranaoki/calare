class AddTimeToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :starttime_of_day, :string
    add_column :groups, :endtime_of_day, :string
  end
end
