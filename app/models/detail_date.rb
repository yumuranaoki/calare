class DetailDate < ApplicationRecord
  belongs_to :submission
  has_many :passive_submission_relationships, class_name: "SubmissionRelationship",
                                              foreign_key: "followed_id",
                                              dependent: :destroy
  has_many :followers, through: :passive_submission_relationships

  has_many :passive_user_detail_relationships, class_name: "DetailDateRelationship",
                                                foreign_key: "followed_id",
                                                dependent: :destroy
  has_many :user_followers, through: :passive_user_detail_relationships, source: :follower

  def followed_by?(submission)
    followers.include?(submission)
  end
end
