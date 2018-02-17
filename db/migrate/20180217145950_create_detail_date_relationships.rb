class CreateDetailDateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :detail_date_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index  :detail_date_relationships, [:follower_id, :followed_id], unique: true
  end
end
