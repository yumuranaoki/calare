module GroupsHelper
  def convinient_group
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
end
