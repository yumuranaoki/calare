class RemoveGroupRefFromDetailDates < ActiveRecord::Migration[5.1]
  def change
    remove_reference :detail_dates, :group, foreign_key: true
  end
end
