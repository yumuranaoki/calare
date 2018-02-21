class SubmissionsController < ApplicationController
  def create
    count = 0
    #submissionを作成
    #access_idに使用。js.erbに渡して、modal表示
    @access_id = SecureRandom::urlsafe_base64(64)
    if Rails.env.development?
      @link = 'http://localhost:3000/s/' + @access_id
    elsif Rails.env.production?
      @link = 'https://calare.herokuapp.com//s/' + @access_id
    end
    @title = params[:title]
    submission = current_user.submissions.create(title: @title, access_id: @access_id, more_than_two: params[:radio_val])
    #配列に突っ込む
    array = params[:array]
    number = ((array.length)/2 - 1)
    #ループ回して１つずつpostする
    for i in 0..number do
      tmp_start = array[2*i]
      tmp_end = array[(2*i+1)]
      startt = tmp_start.split.slice(0, 5).join(" ")
      endt = tmp_end.split.slice(0, 5).join(" ")
      starttime = Time.strptime(startt, "%a %b %d %Y %H:%M:%S").ago(9.hours)
      endtime = Time.strptime(endt, "%a %b %d %Y %H:%M:%S").ago(9.hours)
      if submission.detail_dates.create(
        starttime: starttime,
        endtime: endtime
        )
        count += 1
      end
    end
    current_user.follow_submission(submission)
    respond_to do |format|
      if count==(number+1)
        logger.debug("save成功")
        format.js { @status = 'success' }
      else
        logger.debug("save失敗")
        format.js { @status = 'fail' }
      end
    end
  end

  def show
    @submission = Submission.find_by(access_id: params[:access_id])
    #ユーザーの情報をjsに送る
    #作成者か招待者か
    if logged_in?
      gon.selfcreate = (current_user == @submission.user) ? true : false
    else
      gon.selfcreate = false
    end
    #logginユーザー
    gon.logged_in = logged_in?
    #２人ページ or 複数
    gon.more_than_two = @submission.more_than_two
    #調整が終了しているか
    gon.finishedFlag = @submission.finished_flag
    #締め切っているか
    gon.expiredFlag = @submission.expired_flag
    #submissionのid
    gon.submission_id = @submission.id
    #submissonのdetail_dateの取扱い
    detail_dates_arr = []
    detail_dates_id_arr = []
    detail_dates = @submission.detail_dates
    detail_dates.each do |d|
      detail_dates_arr << {id: d.id, selected: false}
      detail_dates_id_arr << d.id
    end
    gon.detail_dates_arr = detail_dates_arr
    gon.detail_dates_id_arr = detail_dates_id_arr
    if !@submission.followeds.empty?
      @determined_date = "#{@submission.followeds.first.starttime.strftime("%m月%d日%H:%M")}〜#{@submission.followeds.first.endtime.strftime("%m月%d日%H:%M")}まで"
    end

    #ここからmore_than_two && !expired_flag && current_user != @submission.userの際に、ワンクリックで回答できるボタンを作る
    #要領はgoupと一緒、submission.detail_datesでloop回す
    detail_date_auto_arr = []
    if logged_in?
      if @submission.more_than_two && !@submission.expired_flag && current_user != @submission.user

        user_events = current_user.events
        detail_dates.each do |detail_date_each|
          #user_eventsがdetail_dateにかぶっているかを調べる
          #検索(where)とloop回す方法の２つ試す
          #かぶってなかったらそのdetail_dateのselectedをtrueにする
          searched_events = user_events.where(["startday < ? and endday < ?", detail_date_each.starttime, detail_date_each.starttime])
                                        .or(user_events.where(["startday > ? and endday > ?", detail_date_each.endtime, detail_date_each.endtime]))
          if user_events.count == searched_events.count
            detail_date_auto_arr << {id: detail_date_each.id, selected: true}

            #デフォルトを選択させる場合は下のコード
            #detail_dates_arr.each do |d_d|
            #  logger.debug("でばっぐdetail_date_arr前：#{detail_dates_arr}")
            #  logger.debug("でばっぐdetail_date_arr前：#{d_d}")
            #  logger.debug("でばっぐdetail_date_arr前：#{d_d[:id]}")
            #  logger.debug("でばっぐdetail_date_arr前：#{detail_date_each.id}")
            #  if d_d[:id] == detail_date_each.id
            #    d_d[:selected] = true
            #  end
            #  logger.debug("でばっぐdetail_date_arr後：#{detail_dates_arr}")
            #end
          else
            detail_date_auto_arr << {id: detail_date_each.id, selected: false}
          end
        end
        logger.debug("でばっぐdetail_date_auto_arrだす：#{detail_date_auto_arr}")
      end
    end
    gon.detail_date_auto_arr = detail_date_auto_arr
  end

  def destroy
    Submission.find_by(access_id: params[:access_id]).destroy
  end

  #calendarから作成者
  def add_from_submission
    submission = Submission.find_by(access_id: params[:access_id])
    submission.detail_dates.create(id: params[:id],
                                  starttime: params[:start],
                                  endtime: params[:end])
    logger.debug("DBに作成されました")
  end

  def delete_from_submission
    submission = Submission.find_by(access_id: params[:access_id])
    submission.detail_dates.find(params[:id]).destroy
    logger.debug("DBから削除しました")
  end

  def edit_submitted_event
    submission = Submission.find_by(access_id: params[:access_id])
    detail_date = submission.detail_dates.find(params[:id])
    detail_date.update(
      starttime: params[:starttime],
      endtime: params[:endtime]
    )
  end

  #calendarから招待者
  #招待者(submission.user_followers)のカレンダーにも登録
  def determine_detaildate
    logger.debug('デバッグ：ポスト成功')
    logger.debug("ぱらむすメンバーフラッグ#{params[:memberFlag]}")
    submission = Submission.find_by(access_id: params[:access_id])
    detail_date = submission.detail_dates.find(params[:id])
    event_id = params[:event_id]
    parent_user = submission.user
    logger.debug("作成者名は#{parent_user.name}")

    if !parent_user.google_calendars.empty?
      logger.debug("作成者カレンダーありあらり")
      parent_google_calendar = parent_user.google_calendars.order(:id).first
      refresh_token = parent_google_calendar.refresh_token
      client = Signet::OAuth2::Client.new(client_options)
      client.update!(refresh_token: refresh_token)
      response = client.fetch_access_token!
      session[:authorization] = response
      google_calendar_event = Google::Apis::CalendarV3::Event.new(summary: submission.title,
                                                                  start: {date_time: detail_date.starttime.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                  end: {date_time: detail_date.endtime.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                  id: event_id)
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client
      service.insert_event("primary", google_calendar_event)
    end
    #回答者がログインしている場合、回答者のカレンダーにもつっこむ
    if logged_in?
      if parent_user != current_user
        logger.debug("ログインはできます")
        if !current_user.google_calendars.empty?
          logger.debug("招待者カレンダーあります")
          google_calendar = current_user.google_calendars.order(:id).first
          refresh_token = google_calendar.refresh_token
          client = Signet::OAuth2::Client.new(client_options)
          client.update!(refresh_token: refresh_token)
          response = client.fetch_access_token!
          session[:authorization] = response
          google_calendar_event = Google::Apis::CalendarV3::Event.new(summary: submission.title,
                                                                      start: {date_time: detail_date.starttime.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                      end: {date_time: detail_date.endtime.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                      id: event_id)
          service = Google::Apis::CalendarV3::CalendarService.new
          service.authorization = client
          service.insert_event("primary", google_calendar_event)
        #普通にcurrent_user.eventにつっこむ
        end
      end
    end

    #招待者(submission.user_followers)のカレンダーにも登録
    if !submission.user_followers.empty?
      submisson.user_followers.each do |follower|
        if !follower.google_calendars.empty?
          google_calendar = follower.google_calendars.order(:id).first
          refresh_token = google_calendar.refresh_token
          client = Signet::OAuth2::Client.new(client_options)
          client.update!(refresh_token: refresh_token)
          response = client.fetch_access_token!
          session[:authorization] = response
          google_calendar_event = Google::Apis::CalendarV3::Event.new(summary: submission.title,
                                                                      start: {date_time: detail_date.starttime.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                      end: {date_time: detail_date.endtime.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                      id: event_id)
          service = Google::Apis::CalendarV3::CalendarService.new
          service.authorization = client
          service.insert_event("primary", google_calendar_event)
        end
      end
    end

    #２人向けのグループの場合ここで受付終了
    logger.debug("でばっぐ：#{params[:memberFlag]}")
    if params[:memberFlag] == 'true'
      logger.debug("でばっぐ：#{params[:memberFlag]}")
      submission.update(finished_flag: true)
    end
    #submissionと決定したdetail_datesを関連付け
    submission.follow(detail_date)
  end

  def expire
    submission = Submission.find(params[:submission_id])
    submission.update(expired_flag: true)
  end

  def submit_detail_dates
    submission = Submission.find(params[:submission_id])
    detail_dates = submission.detail_dates
    detail_dates_arr = params[:data]
    logger.debug("でえばっぐ：#{detail_dates_arr}")
    detail_dates_arr.each do |index, date|
      if date['selected'] == "true"
        selected_date = detail_dates.find(date['id'])
        selected_date.update(counted: selected_date.counted + 1)
      end
    end
    #submissionをfollowする
    if logged_in?
      current_user.follow(submission)
    end
  end

  def unfollow
    submission = Submission.find_by(access_id: params[:access_id])
    current_user.unfollow_submission(submission)
  end

  private
  def client_options
    {
    client_id: Rails.application.secrets.google_client_id,
    client_secret: Rails.application.secrets.google_client_secret,
    authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
    token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
    scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
    redirect_uri: callback_url
    }
  end

end
