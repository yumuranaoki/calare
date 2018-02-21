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
    @group = Group.find_by(access_id: params[:access_id])
    #calendar.jsに情報を渡す
    #作成者かどうか
    gon.selfcreate = (current_user == @group.user) ? true : false
    #終了しているか
    gon.finished_flag = @group.finished
    gon.multi = @group.multi
    gon.expired_flag = @group.expired_flag
    #detai_date_for_groupsのidの配列
    detail_dates_id_arr = []
    #idとbooleanの配列、カレンダー用
    detail_dates_arr = []
    @group.detail_date_for_groups.each do |detail_date|
      detail_dates_id_arr << detail_date.id
      detail_dates_arr << {id: detail_date.id, selected: false}
    end
    gon.detail_dates_id_arr = detail_dates_id_arr
    gon.detail_dates_arr = detail_dates_arr
    if !@group.followed_detail_dates.empty?
      followed_detail_date = @group.followed_detail_dates.first
      @determined_date = "#{followed_detail_date.starttime.strftime("%m月%d日%H:%M")}~#{followed_detail_date.endtime.strftime("%m月%d日%H:%M")}"
    end
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

  def unfollow
    group = Group.find_by(access_id: params[:access_id])
    current_user.unfollow(group)
  end


    private

      def group_params
        params.require(:group).permit(:title, :content, :starttime, :endtime, :starttime_of_day,
                                      :endtime_of_day, :timelength, :multi, :access_id, :finished)
      end


end
