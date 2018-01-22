class Group < ApplicationRecord
    belongs_to :user
    has_many :passive_relationships, class_name: 'Relationship',
                                     foreign_key: 'followed_id',
                                     dependent: :destroy
    has_many :followers, through: :passive_relationships

    has_many :active_group_user_relationships, class_name: 'GroupUserRelationship',
                                    foreign_key: 'follower_id',
                                    dependent: :destroy
    has_many :followeds, through: :active_group_user_relationships
    has_many :comments
    has_many :answers

    validates :title, presence: true
    validates :starttime, presence: true
    validates :endtime, presence: true
    validates :starttime_of_day, presence: true
    validates :endtime_of_day, presence: true
    validates :timelength, presence: true
    validates :access_id, uniqueness: true
    validate :start_must_be_earlier_than_end

    def start_must_be_earlier_than_end
      if starttime >= endtime || starttime_of_day >= endtime_of_day
        errors.add(:event, ": その日程は設定できません。")
      end
    end

    def follow(other_user)
        active_group_user_relationships.create(followed_id: other_user.id)
    end

    def unfollow(other_user)
        active_group_user_relationships.find_by(followed_id: other_user.id).destroy
    end

    def following?(other_user)
        followeds.include?(other_user)
    end
end
