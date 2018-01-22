class AddResultToSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :result, :string
    remove_column :schedules, :date, :string
  end
end
