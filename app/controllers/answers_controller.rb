class AnswersController < ApplicationController
  after_action :create_notifications, only: [:create]

  def new
    @group = Group.find_by(access_id: params[:access_id])
    @answer = @group.answers.build
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

    @choice = ['00:00', '00:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30', '06:00',
                              '06:30', '07:00', '07:30', '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00',
                              '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00',
                              '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', '22:00', '22:30', '23:00', '23:30']



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
  end

  def create
    @group = Group.find_by(access_id: params[:access_id])
    user = @group.user
    determined_start = params.require(:answer)[:determined_start]
    determined_end = params.require(:answer)[:determined_end]
    determined_day = params.require(:answer)[:determined_day]
    split_start = determined_day.to_s.split[0]
    split_end = determined_day.to_s.split[0]
    starttime_str = split_start << " " << determined_start
    endtime_str = split_end << " " << determined_end
    #文字列をTimeWithZoneに変換
    starttime = Time.zone.strptime(starttime_str,'%Y-%m-%d %H:%M')
    endtime = Time.zone.strptime(endtime_str,'%Y-%m-%d %H:%M')
    logger.debug(starttime)
    character = "abcdefghijklmnopqrstuv0123456789"
    character_length = character.length - 1
    calendar_id = ''
    25.times {
      i = rand(0..character_length)
      str = character[i]
      calendar_id << str
    }
    #@group.userに知らせる　＆　calendarに登録
    respond_to do |format|
      @answer = @group.answers.build(answer_params)
      if @answer.save
        @group.update(finished: true)
        user.events.create(title: @group.title, startday: starttime, endday: endtime, calendar_id: calendar_id)
        if !user.google_calendars.empty?
          google_calendar = current_user.google_calendars.order(:id).first
          refresh_token = google_calendar.refresh_token
          client = Signet::OAuth2::Client.new(client_options)
          client.update!(refresh_token: refresh_token)
          response = client.fetch_access_token!
          session[:authorization] = response
          google_calendar_event = Google::Apis::CalendarV3::Event.new(summary: @group.title,
                                                                      start: {date_time: starttime.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                    end: {date_time: endtime.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                      id: calendar_id)
          service = Google::Apis::CalendarV3::CalendarService.new
          service.authorization = client
          service.insert_event("primary", google_calendar_event)
        end
        format.js { @status = 'success' }
      else
        format.js { @status = 'fail' }
        end
    end
  end

    private
      def answer_params
        params.require(:answer).permit(:name, :determined_day, :determined_start, :determined_end)
      end

      def create_notifications
        Notification.create(user_id: @group.user.id, answer_id: @answer.id )
      end

end
