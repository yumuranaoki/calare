class CreateDetailDates < ActiveRecord::Migration[5.1]
  def change
    create_table :detail_dates do |t|
      t.time :starttime
      t.time :endtime
      t.references :submission, foreign_key: true

      t.timestamps
    end
  end
end
