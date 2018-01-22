class GroupUserRelationship < ApplicationRecord
    belongs_to :follower, class_name: 'Group'
    belongs_to :followed, class_name: 'User'
    validates :follower_id, presence: true
    validates :followed_id, presence: true
end
