class Authorization < ApplicationRecord
  belongs_to :user

  def self.create_from_oauth(auth, user)
    Authorization.create(uid: auth["uid"], provider: auth["provider"], user_id: user.id)
  end
end
