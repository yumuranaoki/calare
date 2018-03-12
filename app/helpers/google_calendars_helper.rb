module GoogleCalendarsHelper
  def google_calenar_authentification(google_calendar)
    refresh_token = google_calendar.refresh_token
    logger.debug("デバッグ:#{refresh_token}")
    client = Signet::OAuth2::Client.new(client_options)
    logger.debug("デバッグ:#{client}")
    client.update!(refresh_token: refresh_token)
    response = client.fetch_access_token!
    session[:authorization] = response
    logger.debug("clientのデバッグ：#{client}")
    return client
  end

  def insert_calendar(google_calendar, summary, starttime, endtime, id)
    tmp_event = Google::Apis::CalendarV3::Event.new(summary: summary,
                                                    start: {date_time: starttime},
                                                    end: {date_time: endtime},
                                                    id: id)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    service.insert_event("primary", tmp_event)
  end

  def check_sync(google_calendar)
    if !google_calendar.sync
      redirect_to list_part_url
    else
      google_calendar.update(sync: false)
    end
  end
end
