class AddCountedToDetailDates < ActiveRecord::Migration[5.1]
  def change
    add_column :detail_dates, :counted, :integer, default: 0
  end
end
