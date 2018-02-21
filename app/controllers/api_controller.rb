class ApiController < ApplicationController
  include GoogleCalendarsHelper  
  def receivetime
    starttime = params[:starttime]
    endtime = params[:endtime]
    #受け取ったstarttime,endtimeを"--:--"の文字列にする
    starttime_of_day = (starttime.even?) ? (starttime / 2).to_s << ":00" : ((starttime - 1) / 2).to_s << ":30"
    endtime_of_day = (endtime.even?) ? (endtime / 2).to_s << ":00" : ((endtime - 1) / 2).to_s << ":30"
    submission_starttime = Time.strptime(params[:startdate], "%Y-%m-%d")
    submission_endtime = Time.strptime(params[:enddate], "%Y-%m-%d")
    submission = current_user.submissions.build(title: params[:title],
                                                access_id: params[:eventId],
                                                more_than_two: params[:multi])
    #submission作成
    if submission.save!
                    #ここから空いてる時間からdetail_date_for_group作成
                    startday = submission_starttime.to_s.split[0]
                    endday = submission_endtime.to_s.split[0]
                    #日時の文字列作成
                    starttime_str = startday << " " << starttime_of_day
                    endtime_str = endday << " " << endtime_of_day
                    #文字列をTimeWithZoneに変換
                    starttime = Time.zone.strptime(starttime_str,'%Y-%m-%d %H:%M')
                    endtime = Time.zone.strptime(endtime_str,'%Y-%m-%d %H:%M')
                    #自分の空いてる時間をとってきてsubmission同様にする
                    #最終日 - 初日
                    diff_of_day = ((submission_endtime - submission_starttime) / 3600 / 24).to_i
                    #終わる時間　- 始まる時間　（30分単位）
                    hour_of_start = starttime_of_day.split(":")[0].to_i
                    min_of_start = starttime_of_day.split(":")[1].to_i
                    hour_of_end = endtime_of_day.split(":")[0].to_i
                    min_of_end = endtime_of_day.split(":")[1].to_i
                    starttime_of_day = (min_of_start == 0) ? hour_of_start*2 : hour_of_start*2 + 1
                    endtime_of_day = (min_of_end == 0) ? hour_of_end*2 : hour_of_end*2 + 1
                    diff_of_half_hour = (endtime_of_day - starttime_of_day - 1 >= 0) ? endtime_of_day - starttime_of_day - 1 : 0
                    events = submission.user.events.where(["endday > ?", starttime]).or(submission.user.events.where(["startday < ?", endtime]))
                    num_of_events = events.count
                    convinient_time_array = []
                    inconvinient_event_arr = []
                    for num_of_day in 0..diff_of_day
                      for num_of_half_hour in 48*num_of_day..48*num_of_day + diff_of_half_hour
                        #指定した範囲内の30分をひたすら繰り返す
                        #groupを作成したユーザーのイベントをループ
                        events_count = 0
                        events.each do |event|
                          if event.endday < starttime.since(30*num_of_half_hour.minutes) || starttime.since(30*(num_of_half_hour + 1).minutes) < event.startday
                            events_count += 1
                          else
                            inconvinient_event_arr << [num_of_half_hour, event.endday, starttime.since(30*num_of_half_hour.minutes), starttime.since(30*(num_of_half_hour + 1).minutes), event.startday]
                          end
                        end
                        convinient_time_array << num_of_half_hour if num_of_events == events_count
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

                    result = []
                    complete_array_saved = complete_array
                    if complete_array.count == 1 && convinient_time_array.count > 1
                      number_start = convinient_time_array[0]
                      number_end = convinient_time_array[-1] + 1
                      if number_end - number_start >= params[:timelength]
                        result << [number_start, number_end]
                      end
                    elsif complete_array.count > 1
                      while complete_array.index {|item| item =~ /^t/ } do
                        position_end = complete_array.index {|item| item =~ /^t/ }
                        #+1するのは時間のloopで+1まで調べているから
                        number_end = complete_array[position_end].delete("to").to_i + 1
                        complete_array.delete_at(position_end)
                        position_start = position_end - 1
                        number_start = complete_array[position_start]
                        if number_end - number_start >= params[:timelength]
                          result << [number_start, number_end]
                        end
                      end
                      if complete_array[-1] != convinient_time_array[-1]
                        number_start = complete_array_saved[-1]
                        number_end = convinient_time_array[-1] + 1
                        if number_end - number_start >= params[:timelength]*2
                          result << [number_start, number_end]
                        end
                      end
                    else
                    end
                    logger.debug("結果は#{result}")

                    #この結果をcalendarに落とし込む
                    #resultに対してeachでloop回して、startとendを登録
                    #idほしいから、groupにdetail_date紐付けて、イベントの個数だけdetail_date作成する
                    result.each do |r|
                      submission.detail_dates.create!(starttime: starttime.since(r[0]*30.minutes), endtime: starttime.since(r[1]*30.minutes))
                    end


    end
    current_user.follow_submission(submission)
  end

  #招待者がイベントをクリックした際にpostされる
  def determine_by_i_from_g
    id = params[:id]
    access_id = params[:accessId]
    group = Group.find_by(aceess_id: access_id)
    detail_date_for_group = group.detail_date_for_groups.find(id)
    #カレンダー登録に必要な事項（共通）
    summary = group.title
    starttime = detail_date_for_group.starttime.strftime("%Y-%m-%dT%H:%M:%S+09:00")
    endtime = detail_date_for_group.endtime.strftime("%Y-%m-%dT%H:%M:%S+09:00")
    event_id = params[:eventId]
    #detail_dateを作成者のcalendarに登録する
    if !group.user.google_calendars.empty?
      google_calendar = group.user.google_calendars.first
      insert_calendar(google_calendar, summary, starttime, endtime, event_id)
    end
    #detail_dateを回答者のcalendarに登録する
    if logged_in?
      #回答者が答えたときのみ
      if current_user != group.user
        if !current_user.google_calendars.empty?
          invited_google_calendar = current_user.google_calendars.first
          insert_calendar(invited_google_calendar, summary, starttime, endtime, event_id)
        end
      end
    end
    #followerのカレンダーにも追加
    if !group.user_followers.empty?
      group.user_followers.each do |follower|
        if !follower.google_calendars.empty?
          tmp_google_calendar = follower.google_calendars.first
          insert_calendar(tmp_google_calendar, starttime, endtime, event_id)
        end
      end
    end
    #detail_dateをgroupsと関連付ける
    group.follow_detail_date(detail_date)
    #ユーザーがgroupをfollow
    if logged_in?
      current_user.follow(group)
    end
    #finishedをtrueに
    group.update!(finished: true)
  end

  def expire_group
    group = Group.find_by(aceess_id: params[:access_id])
    group.update!(expired_flag: true)
  end

  def submit_detaildates
    group = Group.find_by(aceess_id: params[:accessId])
    detail_date_for_groups = group.detail_date_for_groups
    detail_dates_arr = params[:data]
    #招待者用のカレンダーで選択されたイベントをcount
    detail_dates_arr.each do |detail_date|
      if detail_date['selected'] == true
        detail_date_id = detail_date['id']
        tmp = detail_dates.find(detail_date_id)
        tmp.update!(counted: tmp.counted + 1)
      end
    end
    if logged_in?
      current_user.follow(group)
    end
  end

end
