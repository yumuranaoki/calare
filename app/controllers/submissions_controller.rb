class SubmissionsController < ApplicationController
  def create
    count = 0
    #submissionを作成
    #access_idに使用。js.erbに渡して、modal表示
    @access_id = SecureRandom::urlsafe_base64(64)
    if Rails.env.development?
      @link = 'http://localhost:3000/s/' + @access_id
    elsif Rails.env.production?
      @link = 'https://calare.herokuapp.com//s/' + @access_id
    end
    submission = current_user.submissions.create(access_id: @access_id)
    #配列に突っ込む
    array = params[:array]
    number = ((array.length)/2 - 1)
    #ループ回して１つずつpostする
    for i in 0..number do
      tmp_start = array[2*i]
      tmp_end = array[(2*i+1)]
      startt = tmp_start.split.slice(0, 5).join(" ")
      endt = tmp_end.split.slice(0, 5).join(" ")
      starttime = Time.strptime(startt, "%a %b %d %Y %H:%M:%S").ago(9.hours)
      endtime = Time.strptime(endt, "%a %b %d %Y %H:%M:%S").ago(9.hours)
      if submission.detail_dates.create(
        starttime: starttime,
        endtime: endtime
        )
        count += 1
      end
    end

    respond_to do |format|
      if count==(number+1)
        logger.debug("save成功")
        format.js { @status = 'success' }
      else
        logger.debug("save失敗")
        format.js { @status = 'fail' }
      end
    end
  end

  def show
    @submission = Submission.find_by(access_id: params[:access_id])
  end

end
