class AddDetailsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :starttime, :integer
    add_column :events, :endtime, :integer
  end
end
