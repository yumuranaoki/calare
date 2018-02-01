class RemoveSubmission < ActiveRecord::Migration[5.1]
  def change
    drop_table :submissions
  end
end
