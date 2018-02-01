class RemoveDetailsFromSubmissions < ActiveRecord::Migration[5.1]
  def change
    remove_column :submissions, :first, :boolean
  end
end
