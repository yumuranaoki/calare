class AddCommentToSchedules < ActiveRecord::Migration[5.1]
  def change
    add_reference :schedules, :comment, foreign_key: true
  end
end
