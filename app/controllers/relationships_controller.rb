class RelationshipsController < ApplicationController
  
  def show
    @group = Group.find(params[:followed_id])
  end
  
  def create
    group = Group.find(params[:followed_id])
    current_user.follow(group)
    redirect_to participating_path
  end

  def destroy
    group = Relationship.find(params[:id]).followed
    current_user.unfollow(group)
    redirect_to participating_path
  end
end
