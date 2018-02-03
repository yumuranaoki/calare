class AddDetailsToDetailDates < ActiveRecord::Migration[5.1]
  def change
    add_column :detail_dates, :starttime, :datetime
    add_column :detail_dates, :endtime, :datetime
  end
end
