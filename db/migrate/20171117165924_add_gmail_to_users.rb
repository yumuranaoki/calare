class AddGmailToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gmail, :string
  end
end
