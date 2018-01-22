class UserRelationsController < ApplicationController
  def show
  end

  def create
    followed_user = User.find(params[:user_followed_id])
    current_user.follow_user(followed_user)
    redirect_to current_user 
  end

  def destroy
    user = UserRelation.find(params[:id]).user_followed
    current_user.unfollow_user(user)
    redirect_to current_user
  end
end
