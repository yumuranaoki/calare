class AddExpiredFlagToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :expired_flag, :boolean, default: false
  end
end
