class Submission < ApplicationRecord
  belongs_to :user
  has_many :detail_dates, dependent: :destroy 
  validates :access_id, uniqueness: true
  validates :access_id, presence: true
end
