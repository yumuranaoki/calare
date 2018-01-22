class RemoveCommentsFromSchedules < ActiveRecord::Migration[5.1]
  def change
    remove_reference :schedules, :comments, foreign_key: true
  end
end
