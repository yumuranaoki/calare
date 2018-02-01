class AddIsFirstToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :is_first, :boolean, default: true
  end
end
