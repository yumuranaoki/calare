class GoogleCalendarsController < ApplicationController
    #refresh_tokenのruleで場合分け
    def redirect
        client = Signet::OAuth2::Client.new(client_options)
        redirect_to client.authorization_uri.to_s
    end

    def callback
        client = Signet::OAuth2::Client.new(client_options)
        client.code = params[:code]
        response = client.fetch_access_token!
        session[:authorization] = response
        logger.debug("いくそぞｚｆじゃｆじゃお：#{client}")
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        email = service.get_calendar('primary')
        refresh_token = client.refresh_token
        logger.debug("ここここここっここここここここここ#{refresh_token}")
        #同じカレンダーで複数登録してしまうリスク
        google_calendar = current_user.google_calendars.build(email: email.summary,
                                          refresh_token: refresh_token,
                                          sync: false,
                                          next_sync_token: '')
        if google_calendar.save
            redirect_to list_all_url
        else
            flash[:danger] = "google calendarの認証に失敗しました。"
            redirect_to you_path
        end
    end


    def list_all
        client = Signet::OAuth2::Client.new(client_options)
        client.update!(session[:authorization])
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        email = service.get_calendar('primary')
        event_list = service.list_events('primary')
        event_hash = event_list.to_h
        logger.debug("デバッグ：　#{event_hash[:next_sync_token]}")
        event_list.items.each do |e|
            if e.start
                event = current_user.events.build(title: e.summary,
                                                startday: e.start.date_time,
                                                endday: e.end.date_time,
                                                calendar_id: e.id)
                event.save
            end
        end
        #event_hash[:next_sync_token]をcurrent_user.google_calendarsに保存
        #メールアドレスで検索
        google_calendar = current_user.google_calendars.find_by(email: email.summary)
        if google_calendar.update(sync: true, next_sync_token: event_hash[:next_sync_token])
            logger.debug('list_allのupdate成功')
            redirect_to you_path
        else
            logger.debug('list_allのupdate失敗')
        end
    end

    def list_part
        client = Signet::OAuth2::Client.new(client_options)
        client.update!(session[:authorization])
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        email = service.get_calendar('primary')
        google_calendar = current_user.google_calendars.find_by(email: email.summary)
        event_list = service.list_events('primary', 'sync_token': google_calendar.next_sync_token)
        #保存する & status: deleteのもはここで削除
        #page_tokenについての記述
        event_hash = event_list.to_h
        event_list.items.each do |e|
            if e.status == "cancelled"
                event = current_user.events.find_by(calendar_id: e.id)
                if !event.nil?
                    event.destroy
                end
            end
            if !e.start.nil?
                if !current_user.events.find_by(calendar_id: e.id).nil?
                    event = current_user.events.find_by(calendar_id: e.id)
                    event.update(title: e.summary,
                                startday: e.start.date_time,
                                endday: e.end.date_time)
                else
                    event = current_user.events.build(title: e.summary,
                                                      startday: e.start.date_time,
                                                      endday: e.end.date_time,
                                                      calendar_id: e.id)
                    event.save
                end
            end
        end
        google_calendar.update(next_sync_token: event_hash[:next_sync_token])
        google_calendar.update(sync: true)
        redirect_to you_path
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
