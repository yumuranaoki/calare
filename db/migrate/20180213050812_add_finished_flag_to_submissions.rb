class AddFinishedFlagToSubmissions < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :finished_flag, :boolean, default: false
  end
end
