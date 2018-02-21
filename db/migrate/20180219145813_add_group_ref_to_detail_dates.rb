class AddGroupRefToDetailDates < ActiveRecord::Migration[5.1]
  def change
    add_reference :detail_dates, :group, foreign_key: true
  end
end
