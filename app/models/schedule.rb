class Schedule < ApplicationRecord
  belongs_to :comment,optional: true
end
