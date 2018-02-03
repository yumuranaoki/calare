module UsersHelper
  def user_show
    @group = current_user.groups.build
    @choice = ['00:00', '00:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30', '06:00',
                              '06:30', '07:00', '07:30', '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00',
                              '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00',
                              '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', '22:00', '22:30', '23:00', '23:30']

    @access_id = SecureRandom::urlsafe_base64(64)

    if !current_user.google_calendars.empty?
      google_calendar = current_user.google_calendars.order(:id).first
      refresh_token = google_calendar.refresh_token
      client = Signet::OAuth2::Client.new(client_options)
      client.update!(refresh_token: refresh_token)
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
