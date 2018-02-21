class AddIndexToDetailDateForGroup < ActiveRecord::Migration[5.1]
  def change
    change_column :detail_date_for_groups, :counted, :integer, default: 0
  end
end
