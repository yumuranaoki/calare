class EventsController < ApplicationController

  def show
  end

  def new
    @event = current_user.events.build
    character = "abcdefghijklmnopqrstuv0123456789"
    character_length = character.length - 1
    @calendar_id = ''
    25.times {
      i = rand(0..character_length)
      str = character[i]
      @calendar_id << str
    }
    logger.debug(@calendar_id)
  end

  def index
    events = current_user.events
    @modified_events = []
    events.each do |e|
      tmp_events = {'id': e.id,
                    'title': e.title,
                    'start': e.startday,
                    'end': e.endday,
                    'calendar_id': e.calendar_id}
      @modified_events << tmp_events
    end
    render json: @modified_events
  end

  #google calendarにもつっこまないといけない
  #fullcalendarにも?
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      if !current_user.google_calendars.empty?
        google_calendar = current_user.google_calendars.order(:id).first
        refresh_token = google_calendar.refresh_token
        client = Signet::OAuth2::Client.new(client_options)
        client.update!(refresh_token: refresh_token)
        response = client.fetch_access_token!
        session[:authorization] = response
        google_calendar_event = Google::Apis::CalendarV3::Event.new(summary: @event.title,
                                                                    start: {date_time: @event.startday.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                  end: {date_time: @event.endday.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                    id: @event.calendar_id)
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        service.insert_event("primary", google_calendar_event)
      end
    end
    respond_to do |format|
      if @event.save
        logger.debug("save成功")
        format.js { @status = 'success' }
      else
        logger.debug("save失敗")
        format.js { @status = 'fail' }
      end
    end
  end


  def destroy
  end

  def delete_event
    if !current_user.google_calendars.empty?
      google_calendar = current_user.google_calendars.order(:id).first
      refresh_token = google_calendar.refresh_token
      client = Signet::OAuth2::Client.new(client_options)
      client.update!(refresh_token: refresh_token)
      response = client.fetch_access_token!
      session[:authorization] = response
      logger.debug("responseは#{response}")
      #idはrailsのeventのid、calendar_idはgooglecalendarのeventのid
      event = current_user.events.find_by(params[:id])
      if !event.calendar_id.nil?
        #calendar_idだけ先にとっておく
        calendar_id = event.calendar_id
        logger.debug("calendar_idは#{calendar_id}")
        #google calendarでも消す
        logger.debug("clientは#{client}")
        service = Google::Apis::CalendarV3::CalendarService.new
        logger.debug("serviceは#{service}")
        service.authorization = client
        logger.debug("authorization完了")
        service.delete_event('primary', calendar_id)
        logger.debug("google_calendarから消しました")
      end
    end
    logger.debug("event_idは#{params[:id]}")
    #DBから消す
    current_user.events.find(params[:id]).destroy
    logger.debug("DBから消しました")
  rescue Google::Apis::ClientError
    logger.debug("いつものエラーです")
    current_user.events.find(params[:id]).destroy
    logger.debug("DBから消しました")
  end

  def create_event
    google_calendar = current_user.google_calendars.order(:id).first
    refresh_token = google_calendar.refresh_token
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(refresh_token: refresh_token)
    response = client.fetch_access_token!
    session[:authorization] = response
    event = current_user.events.build
    event.attributes = {
      title: params[:title],
      startday: params[:start],
      endday: params[:end],
      calendar_id: params[:calendar_id]
    }
    logger.debug("calendar_idは#{event.calendar_id}")
    google_calendar_event = Google::Apis::CalendarV3::Event.new(summary: event.title,
                                                                start: {date_time: event.startday.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                              end: {date_time: event.endday.strftime("%Y-%m-%dT%H:%M:%S+09:00")},
                                                                id: event.calendar_id)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    service.insert_event("primary", google_calendar_event)
    event.save
  end

  def edit_event
    starttime = params[:start] + "+09:00"
    endtime = params[:end] + "+09:00"
    logger.debug("startの時間は#{starttime}")
    logger.debug("startの時間は#{endtime}")
    #まずrailsのDBを編集
    event = current_user.events.find(params[:id])
    logger.debug("eventは#{event.title}")
    if event.update(startday: starttime,
                    endday: endtime)
       logger.debug("railsのDBでupdate")
    end
    #google_calenarでのupdate
    google_calendar = current_user.google_calendars.order(:id).first
    refresh_token = google_calendar.refresh_token
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(refresh_token: refresh_token)
    response = client.fetch_access_token!
    session[:authorization] = response
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    calendar_id = event.calendar_id
    google_calendar_event = service.get_event('primary', calendar_id)
    google_calendar_event.start.date_time = starttime
    google_calendar_event.end.date_time = endtime
    service.update_event('primary', calendar_id, google_calendar_event)
  end

    private
      def event_params
        params.require(:event).permit(:title, :startday, :endday, :calendar_id)
      end

      def create_time
        startday = event.startday.to_s.split[0]
        endday = event.endday.to_s.split[0]
        starttime_str = startday << ' ' << starttime
        endtime_str = endday << ' ' << endtime
        starttime = Time.zone.strptime(starttime_str, '%Y-%m-%d %H:%M')
        endtime = Time.zone.strptime(endtime_str, '%Y-%m-%d %H:%M')
      end

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
