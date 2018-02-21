class DetailDateForGroup < ApplicationRecord
  #groupにfollowされる
  has_many :passive_group_detail_relationships, class_name: "GroupDetailRelationship",
                                                foreign_key: "followed_id",
                                                dependent: :destroy
  has_many :group_followers, through: :passive_group_detail_relationships, source: :follower

  belongs_to :group

  def followed_by?(group)
    group_followers.include?(group)
  end
end
