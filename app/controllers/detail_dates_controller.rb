class DetailDatesController < ApplicationController
  def index
    submission = Submission.find_by(access_id: params[:access_id])
    detail_dates = submission.detail_dates
    modified_detail_dates = []
    detail_dates.each do |d|
      tmp_events = {'id': d.id,
                    'start': d.starttime,
                    'end': d.endtime,
                    'title': (d.followed_by?(submission))  ? "決定しました" : (d.counted != 0) ? d.counted : 0 ,
                    'color': (d.followed_by?(submission))  ? "rgb(214, 76, 97)" : "#cecece"
                  }
      modified_detail_dates << tmp_events
    end
    render json: modified_detail_dates
  end

  def index_for_auto
    submission = Submission.find_by(access_id: params[:access_id])
    detail_dates = submission.detail_dates
    detail_date_auto_arr = []
    if logged_in?
      if submission.more_than_two && !submission.expired_flag && current_user != submission.user
        user_events = current_user.events
        detail_dates.each do |detail_date_each|
          #user_eventsがdetail_dateにかぶっているかを調べる
          #かぶってなかったらそのdetail_dateのselectedをtrueにする
          searched_events = user_events.where(["startday < ? and endday < ?", detail_date_each.starttime, detail_date_each.starttime])
                                        .or(user_events.where(["startday > ? and endday > ?", detail_date_each.endtime, detail_date_each.endtime]))
          if user_events.count == searched_events.count
            tmp_events = {'id': detail_date_each.id,
                          'start': detail_date_each.starttime,
                          'end': detail_date_each.endtime,
                          'title':  detail_date_each.counted + 1,
                          'color': "rgb(26, 211, 236)"
            }
          else
            tmp_events = {'id': detail_date_each.id,
                          'start': detail_date_each.starttime,
                          'end': detail_date_each.endtime,
                          'title':  detail_date_each.counted,
                          'color': "#cecece"
            }
          end
          detail_date_auto_arr << tmp_events
        end
        logger.debug("でばっぐdetail_date_auto_arrだす：#{detail_date_auto_arr}")
        render json: detail_date_auto_arr
      end
    end
  end
end
