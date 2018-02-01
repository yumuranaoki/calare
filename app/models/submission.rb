class Submission < ApplicationRecord
  belongs_to :user
  has_many :detail_dates
end
