class RenameStartColumnToEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :start, :startday
    rename_column :events, :end, :endday
  end
end
