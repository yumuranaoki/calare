class CreateUserRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :user_relations do |t|
      t.integer :user_follower_id
      t.integer :user_followed_id

      t.timestamps
    end
  end
end
