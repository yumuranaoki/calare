class Event < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :startday, presence: true
  validates :endday, presence: true
  validates :user_id, presence: true
  validates :calendar_id, uniqueness: true
  validate :start_must_be_earlier_than_end

  def start_must_be_earlier_than_end
    if startday >= endday
      errors.add(:event, ": その日程は設定できません。")
    end
  end


end
