class RemoveGmailFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :gmail, :string
  end
end
