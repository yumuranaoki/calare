class Comment < ApplicationRecord
  belongs_to :group
  has_many :schedules
  accepts_nested_attributes_for :schedules
end
