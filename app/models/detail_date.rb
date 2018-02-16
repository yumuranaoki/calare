class DetailDate < ApplicationRecord
  belongs_to :submission
  has_many :passive_submission_relationships, class_name: "SubmissionRelationship",
                                              foreign_key: "followed_id",
                                              dependent: :destroy
  has_many :followers, through: :passive_submission_relationships

  def followed_by?(submission)
    followers.include?(submission)
  end
end
