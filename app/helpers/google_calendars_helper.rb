module GoogleCalendarsHelper
  def google_calenar_authentification
    refresh_token = google_calendar.refresh_token
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(refresh_token: refresh_token)
    response = client.fetch_access_token!
    session[:authorization] = response
  end

  def insert_calendar(google_calendar, summary, starttime, endtime, id)
    refresh_token = google_calendar.refresh_token
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(refresh_token: refresh_token)
    response = client.fetch_access_token!
    session[:authorization] = response
    tmp_event = Google::Apis::CalendarV3::Event.new(summary: summary,
                                                    start: {date_time: starttime},
                                                    end: {date_time: endtime},
                                                    id: id)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client
    service.insert_event("primary", tmp_event)
  end
end
