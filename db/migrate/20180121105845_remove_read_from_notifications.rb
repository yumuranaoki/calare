class RemoveReadFromNotifications < ActiveRecord::Migration[5.1]
  def change
    remove_column :notifications, :read, :boolean
  end
end
