class DetailDateForGroupsController < ApplicationController
  def index
    group = Group.find_by(access_id: params[:access_id])
    detail_date_for_groups = group.detail_date_for_groups
    modified_detail_date_for_groups = []
    detail_date_for_groups.each do |d|
      tmp_events = { 'id': d.id,
                    'start': d.starttime,
                    'end': d.endtime,
                    'title': (d.followed_by?(group)) ? "決定しました" : d.counted ,
                    'color': (d.followed_by?(group)) ? "rgb(214, 76, 97)" : "#cecece"
                  }
      modified_detail_date_for_groups << tmp_events
    end
    render json: modified_detail_date_for_groups
  end

  def index_for_auto
    group = Group.find_by(access_id: params[:access_id])
    detail_dates = group.detail_date_for_groups
    detail_date_auto_arr = []
    if logged_in?
      if group.multi && !group.expired_flag && current_user != group.user
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
        render json: detail_date_auto_arr
      end
    end
  end
end
