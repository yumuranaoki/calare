class AddDateToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :date, :text, array: true
  end
end
