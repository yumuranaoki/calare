class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.boolean :first, default: true
      t.boolean :determined, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
