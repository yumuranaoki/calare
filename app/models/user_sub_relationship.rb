class UserSubRelationship < ApplicationRecord
  belongs_to :followed, class_name: 'Submission'
  belongs_to :follower, class_name: 'User'
  validates :followed_id, presence: true
  validates :follower_id, presence: true
end
