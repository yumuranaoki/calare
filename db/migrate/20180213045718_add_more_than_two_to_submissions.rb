class AddMoreThanTwoToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :more_than_two, :boolean
  end
end
