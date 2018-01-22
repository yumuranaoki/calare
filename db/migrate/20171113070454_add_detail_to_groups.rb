class AddDetailToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :starttime, :datetime
    add_column :groups, :timelength, :integer
  end
end
