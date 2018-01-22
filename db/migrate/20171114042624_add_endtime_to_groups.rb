class AddEndtimeToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :endtime, :datetime
  end
end
