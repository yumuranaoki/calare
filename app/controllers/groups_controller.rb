class GroupsController < ApplicationController
  include GroupsHelper
  def index
    @groups = current_user.groups
    user_show
  end

  #記録用が多いので後で消す
  #groupにアクセスIDを追加、validate
  #@group = Group.find_by(access_id: params[:access_id])
  #followしたときの挙動しらべてredirectも変える
  def show
    convinient_group
  end

  def new
    @group = current_user.groups.build
    @access_id = SecureRandom::urlsafe_base64(64)
    @choice = CHOICE
  end

  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      current_user.follow(@group)
    end
    respond_to do |format|
      if @group.save
        logger.debug("save成功")
        format.js { @status = 'success' }
      else
        logger.debug("save失敗")
        format.js { @status = 'fail' }
      end
    end
  end

  def edit
    @group = Group.find_by(access_id: params[:access_id])
    @choice = CHOICE
  end

  def update
    @group = Group.find_by(access_id: params[:access_id])
    respond_to do |format|
      if @group.update_attributes(group_params)
        format.js { @status = 'success' }
      else
        format.js { @status = 'fail' }
      end
    end
  end

  def destroy
  end

    private

      def group_params
        params.require(:group).permit(:title, :content, :starttime, :endtime, :starttime_of_day,
                                      :endtime_of_day, :timelength, :multi, :access_id, :finished)
      end


end
