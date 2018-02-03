class RemoveTwoFromSubmissions < ActiveRecord::Migration[5.1]
  def change
    remove_column :submissions, :determined, :boolean
    remove_column :submissions, :is_first, :boolean
  end
end
