class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.references :comments, foreign_key: true

      t.timestamps
    end
  end
end
