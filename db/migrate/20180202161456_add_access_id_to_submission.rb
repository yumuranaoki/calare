class AddAccessIdToSubmission < ActiveRecord::Migration[5.1]
  def change
    add_column :submissions, :access_id, :string
  end
end
