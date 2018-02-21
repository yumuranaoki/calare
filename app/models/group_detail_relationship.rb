class GroupDetailRelationship < ApplicationRecord
  belongs_to :followed, class_name: "DetailDateForGroup"
  belongs_to :follower, class_name: "Group"
  validates :followed_id, presence: true
  validates :follower_id, presence: true
end
