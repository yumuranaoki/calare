class CreateGroupUserRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :group_user_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :group_user_relationships, :follower_id
    add_index :group_user_relationships, :followed_id
    add_index :group_user_relationships, [:follower_id, :followed_id], unique: true
  end
end
