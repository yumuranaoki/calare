class RenameEndColumnToEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :end, :endtime
  end
end
