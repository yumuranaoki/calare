class AddDtailsToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :determined_day, :Date
    add_column :answers, :determined_start, :string
    add_column :answers, :determined_end, :string
    add_column :answers, :calendar_id, :string
  end
end
