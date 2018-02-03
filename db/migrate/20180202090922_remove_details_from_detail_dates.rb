class RemoveDetailsFromDetailDates < ActiveRecord::Migration[5.1]
  def change
    remove_column :detail_dates, :starttime, :time
    remove_column :detail_dates, :endtime, :time
  end
end
