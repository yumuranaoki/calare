class CreateDetailDateForGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :detail_date_for_groups do |t|
      t.datetime :starttime
      t.datetime :endtime
      t.integer :counted
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
