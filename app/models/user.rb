class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token
    before_create :create_activation_digest
    has_secure_password
    before_save {self.email = email.downcase}
    validates :name, presence: true, length: { maximum: 20 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
    validates :password, length: {minimum: 4, maximum: 20}, allow_nil: true

    has_many :events, dependent: :destroy
    has_many :groups, dependent: :destroy
    has_many :google_calendars, dependent: :destroy
    has_many :notifications, dependent: :destroy
    has_many :submissions, dependent: :destroy


    has_many :active_relationships, class_name: 'Relationship',
                                    foreign_key: 'follower_id',
                                    dependent: :destroy
    has_many :followeds, through: :active_relationships

    has_many :passive_group_user_relationships, class_name: 'GroupUserRelationship',
                                                foreign_key: 'followed_id',
                                                dependent: :destroy
    has_many :followers, through: :passive_group_user_relationships


    has_many :active_user_relations, class_name: 'UserRelation',
                                    foreign_key: 'user_follower_id',
                                    dependent: :destroy
    has_many :user_followeds, through: :active_user_relations

    has_many :passive_user_relations, class_name: 'UserRelation',
                                     foreign_key: 'user_followed_id',
                                     dependent: :destroy
    has_many :user_followers, through: :passive_user_relations

    has_many :active_user_detail_relationships, class_name: 'DetailDateRelationship',
                                                foreign_key: 'follower_id',
                                                dependent: :destroy
    has_many :followed_detail_dates, through: :active_user_detail_relationships, source: :followed

    has_many :active_user_sub_relationships, class_name: 'UserSubRelationship',
                                                foreign_key: 'follower_id',
                                                dependent: :destroy
    has_many :followed_submissions, through: :active_user_sub_relationships, source: :followed


    def follow(other_group)
        active_relationships.create(followed_id: other_group.id)
    end

    def unfollow(other_group)
        active_relationships.find_by(followed_id: other_group.id).destroy
    end

    def following?(other_group)
        followeds.include?(other_group)
    end

    def follow_user(other_user)
        active_user_relations.create(user_followed_id: other_user.id)
    end

    def unfollow_user(other_user)
        active_user_relations.find_by(user_followed_id: other_user.id).destroy
    end

    def following_user?(other_user)
        followeds.include?(other_user)
    end

    def follow_detail_date(detail_date)
        active_user_detail_relationships.create(followed_id: detail_date.id)
    end

    def unfollow_detail_date(detail_date)
        active_user_detail_relationships.find_by(followed_id: detail_date.id).destroy
    end

    def follow_submission(submission)
        active_user_sub_relationships.create(followed_id: submission.id)
    end

    def unfollow_submission(submission)
        active_user_sub_relationships.find_by(followed_id: submission.id).destroy
    end

    def self.search(search)
        if search
            where('name LIKE ?', "%#{search}%")
        else
            all
        end
    end

    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def self.new_token
         SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    # アカウントを有効にする
    def activate
        update_attribute(:activated,    true)
        update_attribute(:activated_at, Time.zone.now)
    end

    # 有効化用のメールを送信する
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    # パスワード再設定の属性を設定する
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    # パスワード再設定のメールを送信する
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end



        private

            def downcase_email
                self.email = email.downcase
            end

            def create_activation_digest
                self.activation_token  = User.new_token
                self.activation_digest = User.digest(activation_token)
            end


end
