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
    submission = current_user.submissions.create(title: @title, access_id: @access_id)
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
    gon.selfcreate = (current_user == @submission.user) ? true : false
    gon.logged_in = logged_in?
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

  #calendarから招待者
  def determine_detaildate
    logger.debug('デバッグ：ポスト成功')
=begin
    submission = Submission.find_by(access_id: params[:access_id])
    detail_date = submission.detail_dates.find(params[:id])
    event_id = params[:event_id]
    parent_user = submission.user
    if !parent_user.google_calendars.empty?
      google_calendar = parent_user.google_calendars.order(:id).first
      refresh_token = google_calendar.refresh_token
      client = Signet::OAuth2::Client.new(client_options)
      client.update!(refresh_token: refresh_token)
      response = client.fetch_access_token!
      session[:authorization] = response
      google_calendar_event = Google::Apis::CalendarV3::Event.new(summary: submission.title,
                                                                  start: {date_time: detail_date.startday.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                end: {date_time: detail_date.endday.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                  id: event_id)
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client
      service.insert_event("primary", google_calendar_event)
    end
    #回答者がログインしている場合、回答者のカレンダーにもつっこむ
    if logged_in?
      if !current_user.google_calendars.empty?
        google_calendar = current_user.google_calendars.order(:id).first
        refresh_token = google_calendar.refresh_token
        client = Signet::OAuth2::Client.new(client_options)
        client.update!(refresh_token: refresh_token)
        response = client.fetch_access_token!
        session[:authorization] = response
        google_calendar_event = Google::Apis::CalendarV3::Event.new(summary: submission.title,
                                                                    start: {date_time: detail_date.startday.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                  end: {date_time: detail_date.endday.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                    id: event_id)
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        service.insert_event("primary", google_calendar_event)
      end
    end
=end
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
