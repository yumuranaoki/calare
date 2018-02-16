class SubmissionRelationship < ApplicationRecord
  belongs_to :followed, class_name: 'DetailDate'
  belongs_to :follower, class_name: 'Submission'
  validates :followed_id, presence: true
  validates :follower_id, presence: true
end
