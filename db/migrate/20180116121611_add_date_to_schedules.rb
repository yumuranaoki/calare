class AddDateToSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :date, :string
  end
end
