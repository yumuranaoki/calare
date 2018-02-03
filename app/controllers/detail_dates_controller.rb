class DetailDatesController < ApplicationController
  def index
    submission = Submission.find_by(access_id: params[:access_id])
    detail_dates = submission.detail_dates
    modified_detail_dates = []
    detail_dates.each do |d|
      tmp_events = {'id': d.id,
                    'start': d.starttime,
                    'end': d.endtime}
      modified_detail_dates << tmp_events
    end
    render json: modified_detail_dates
  end
end
