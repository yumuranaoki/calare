class Answer < ApplicationRecord
  belongs_to :group
  has_many :notifications, dependent: :destroy
end
