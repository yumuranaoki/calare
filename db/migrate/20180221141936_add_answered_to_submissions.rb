class AddAnsweredToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :answered, :boolean, default: false
  end
end
