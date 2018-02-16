class AddExpiredFlagToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :expired_flag, :boolean, default: false
  end
end
