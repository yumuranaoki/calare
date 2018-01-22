class RenameEndtimeColumnToEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :endtime, :end
  end
end
