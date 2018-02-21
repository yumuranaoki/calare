class CreateGroupDetailDateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :group_detail_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index  :group_detail_relationships, [:follower_id, :followed_id], unique: true
  end
end
