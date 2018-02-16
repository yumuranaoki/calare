class Submission < ApplicationRecord
  belongs_to :user
  has_many :detail_dates, dependent: :destroy
  validates :access_id, uniqueness: true
  validates :access_id, presence: true
  validates :title, presence: true

  has_many :active_submission_relationships, class_name: 'SubmissionRelationship',
                                              foreign_key: 'follower_id',
                                              dependent: :destroy
  has_many :followeds, through: :active_submission_relationships

  def follow(detail_date)
    active_submission_relationships.create(followed_id: detail_date.id)
  end

  def unfollow(detail_date)
  end
end
