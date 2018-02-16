class CreateSubmissionRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :submission_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index  :submission_relationships, [:follower_id, :followed_id], unique: true
  end
end
