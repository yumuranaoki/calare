module UsersHelper
  def user_show
    if !current_user.google_calendars.empty?
      google_calendar = current_user.google_calendars.order(:id).first
      logger.debug("google_calendarのデバッグ：#{google_calendar}")
      refresh_token = google_calendar.refresh_token
      logger.debug("google_calendarのデバッグ：#{refresh_token}")
      client = Signet::OAuth2::Client.new(client_options)
      client.update!(refresh_token: refresh_token)
      logger.debug("google_calendarのデバッグ：#{client}")
      response = client.fetch_access_token!
      session[:authorization] = response
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client
      if google_calendar.sync == false
        redirect_to list_part_url
      elsif google_calendar.sync == true
        google_calendar.update(sync: false)
      end
    end

  end
end
