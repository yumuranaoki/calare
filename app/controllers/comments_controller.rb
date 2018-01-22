class CommentsController < ApplicationController
  def new
    @group = Group.find_by(access_id: params[:access_id])
    @comment = @group.comments.build
    #scheule modelも同じformで登録する
    @comment.schedules.build
    startd = @group.starttime.to_s.split[0]
    endd = @group.endtime.to_s.split[0]
    @startday = Date.strptime(startd,'%Y-%m-%d')
    @endday = Date.strptime(endd,'%Y-%m-%d')
    #いらないかも
    @diff_of_day = ((@group.endtime - @group.starttime) / 3600 / 24).to_i
    @comment_num = @diff_of_day + 1
  end

  def create
    group = Group.find_by(access_id: params[:access_id])
    comment = group.comments.build(comment_params)
    comment.save
    respond_to do |format|
      if comment.save
        logger.debug("save成功")
        format.js { @status = 'success' }
      else
        logger.debug("save失敗")
        format.js { @status = 'fail' }
      end
    end
  end


    private
      def comment_params
        params.require(:comment).permit(:name, schedules_attributes: [:date, :result])
      end

end
