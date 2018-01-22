class UserRelation < ApplicationRecord
    belongs_to :user_follower, class_name: 'User'
    belongs_to :user_followed, class_name: 'User'
    validates :user_follower_id, presence: true
    validates :user_followed_id, presence: true
end
