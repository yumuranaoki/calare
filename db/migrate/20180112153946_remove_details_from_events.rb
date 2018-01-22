class RemoveDetailsFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :starttime, :integer
    remove_column :events, :endtime, :integer
  end
end
