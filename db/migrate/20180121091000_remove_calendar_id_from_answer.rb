class RemoveCalendarIdFromAnswer < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :calendar_id, :string
  end
end
