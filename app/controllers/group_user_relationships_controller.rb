class GroupUserRelationshipsController < ApplicationController
  #なにこれ
  def create
    user = User.find(params[:user_id])
    group = user.groups.find(params[:group_id])
    followed_user = User.find(params[:followed_id])
    group.follow(followed_user)
    redirect_to user_group_path(user_id: user, id: group)
  end

  def destroy
    user = User.find(params[:user_id])
    group = user.groups.find(params[:group_id])
    followed_user = GroupUserRelationship.find(params[:id]).followed
    group.unfollow(followed_user)
    redirect_to user_group_path(user_id: user, id: group)
  end

  def show
  end
end
