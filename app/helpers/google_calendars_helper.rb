module GoogleCalendarsHelper
  def google_calenar_authentification
    refresh_token = google_calendar.refresh_token
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(refresh_token: refresh_token)
    response = client.fetch_access_token!
    session[:authorization] = response
  end
end
