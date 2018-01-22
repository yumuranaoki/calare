class GroupsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups
  end

  #記録用が多いので後で消す
  #groupにアクセスIDを追加、validate
  #@group = Group.find_by(access_id: params[:access_id])
  #followしたときの挙動しらべてredirectも変える
  def show
    @users = current_user.user_followeds.search(params[:search])
    @group = Group.find_by(access_id: params[:access_id])
    #jsに情報を渡す
    gon.multi = @group.multi
    #時刻
    @starttime_of_day = @group.starttime_of_day
    @endtime_of_day = @group.endtime_of_day
    #日付
    startday = @group.starttime.to_s.split[0]
    endday = @group.endtime.to_s.split[0]
    #最終日　-　初日
    @diff_of_day = ((@group.endtime - @group.starttime) / 3600 / 24).to_i
    #日時の文字列作成
    starttime_str = startday << " " << @starttime_of_day
    endtime_str = endday << " " << @endtime_of_day
    #文字列をTimeWithZoneに変換
    @starttime = Time.zone.strptime(starttime_str,'%Y-%m-%d %H:%M')
    @endtime = Time.zone.strptime(endtime_str,'%Y-%m-%d %H:%M')
    #スタート、エンドの時刻のh、mを取得
    s_h = @starttime_of_day.split(":")[0].to_i
    s_m = @starttime_of_day.split(":")[1].to_i
    e_h = @endtime_of_day.split(":")[0].to_i
    e_m = @endtime_of_day.split(":")[1].to_i
    #ある１時間において、あるfolowerの予定の内、かぶらなかったものの数
    @event_count = 0
    #ある１時間にかぶらなかった予定。あとで消す
    @convinient_event = []
    #ある１時間にかぶった予定。あとで消す
    @inconvinient_event = []
    #ある１時間に参加できるfollowerの数
    @follower_count = 0
    #すべてのfollowerにとって都合のいい日時
    convinient_time_array = []
    #エンドの時刻とスタートの時刻の差
    #日時の条件判定である時間と一時間後の時間について調べているので　-1
    time_number = e_h - s_h >= 1 ?  e_h - s_h - 1 : 0


    for num_day in 0..@diff_of_day
      for num in Range.new(24*num_day,24*num_day + time_number)
        #follower_loop開始
        #groupのstarttimeとendtimeの間に入っているものだけ取る
        @group.followers.each do |follower|
          arr = follower.events.where("startday < ?", @endtime).where("endday > ?", @starttime)
          if arr.any?
            #取得するeventを絞る（events.where()）
            #event_loop開始
            arr.each do |event|
              num_next = num + 1
              if event.endday < @starttime.since(num.hour) || @starttime.since(num_next.hour) < event.startday
                @event_count += 1
                @convinient_event.push(event.title)
              else
                @inconvinient_event.push(event.title)
              end
            end
            #event_loop終了
            if @event_count == arr.count
              @follower_count += 1
            end
            #reset
            @event_count = 0
          else
            @follower_count += 1
          end
        end
        #follower_loop終了
        if @follower_count == @group.followers.count
          convinient_time_array.push(num)
        end
        #reset
        @follower_count = 0
      end
    end

    #連続する時間をまとめる
    i = convinient_time_array[0]
    complete_array = convinient_time_array.inject([convinient_time_array[0]]) do |r, v|
      if v != i
        if v - r.last >= 2
         r << "to #{i - 1}"
        end
        r << v
        i = v
      end
      i += 1
      r
    end

    completed_time_array = []
    position_start = 0
    position_end = 0
    number_start = 0
    number_end = 0
    logger.debug(convinient_time_array)
    logger.debug(complete_array)
    @result = Array.new
    complete_array_saved = complete_array
    if complete_array.count == 1 && convinient_time_array.count > 1
      number_start = convinient_time_array[0]
      number_end = convinient_time_array[-1] + 1
      if number_end - number_start >= @group.timelength
        @result << [number_start, number_end]
      end
    elsif complete_array.count > 1
      while complete_array.index {|item| item =~ /^t/ } do
        position_end = complete_array.index {|item| item =~ /^t/ }
        number_end = complete_array[position_end].delete("to").to_i + 1
        complete_array.delete_at(position_end)
        position_start = position_end - 1
        number_start = complete_array[position_start]
        if number_end - number_start >= @group.timelength
          @result << [number_start, number_end]
        end
      end
      if complete_array[-1] != convinient_time_array[-1]
        number_start = complete_array_saved[-1]
        number_end = convinient_time_array[-1] + 1
        if number_end - number_start >= @group.timelength
          @result << [number_start, number_end]
        end
      end
    else
    end
    logger.debug("結果は#{@result}")
    @startday_n_others = Date.strptime(@starttime.to_s.split[0],'%Y-%m-%d')
    @schedule = []
    @others_result = Array.new(@diff_of_day + 1).map{Array.new(3,0)}
    @group.comments.each {|c| @schedule << c.schedules}
    for i in 0..@group.comments.count-1
      for l in 0..@diff_of_day
        case @schedule[i].where("date=?", @startday_n_others + l).first.result
        when '1'
          @others_result[l][0] += 1
        when '2'
          @others_result[l][1] += 1
        when '3'
          @others_result[l][2] += 1
        end
      end
    end

    if @group.multi == false
      #final用
      #1.Arrayをつくる
      #2.starttimeのhhからendtime-1のhhまでについて　hh:00, hh:30 をつくる
      #@final_arr = []
      #for number in
    end
  end

  def participating
    @groups = current_user.followeds
  end

  def invited
    @groups = current_user.followers
  end

  def new
    @group = current_user.groups.build
    @access_id = SecureRandom::urlsafe_base64(64)
    @choice = ['00:00', '00:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30', '06:00',
                              '06:30', '07:00', '07:30', '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00',
                              '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00',
                              '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', '22:00', '22:30', '23:00', '23:30']
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
    @choice = ['00:00', '00:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30', '06:00',
                              '06:30', '07:00', '07:30', '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00',
                              '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00',
                              '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', '22:00', '22:30', '23:00', '23:30']
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
