class UsersController < ApplicationController
  include GoogleCalendarsHelper

  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @searched_users = User.search(params[:search])
    @users = @searched_users.paginate(page: params[:page])
  end

  def show
    @user = current_user
    followed_group_id_arr = []
    @user.followeds.each do |group|
      followed_group_id_arr << group.id
    end
    @groups = Group.where(user_id: @user.id).where(id: followed_group_id_arr)
    @g_c = @groups.count - 1
    #followしているsubmissionのidを取ってきて@submissionの検索に加える
    followed_submission_id_arr = []
    @user.followed_submissions.each do |submission|
      followed_submission_id_arr << submission.id
    end
    @submissions = Submission.where(user_id: @user.id).where(id: followed_submission_id_arr)
    @s_c = @submissions.count - 1
    if !current_user.google_calendars.empty?
      google_calendar = current_user.google_calendars.order(:id).first
      google_calenar_authentification(google_calendar)
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client
      check_sync(google_calendar)
    end
  end

  def create
    @user = User.new(user_params)
    logger.debug("ユーザーのメール#{@user.email}")
    if @user.save
      logger.debug("ユーザーを保存しました")
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.user_followeds
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.user_followers
  end

  def participating
    @groups = current_user.followeds
    @g_c = @groups.count - 1
    followed_submission_id_arr = []
    current_user.followed_submissions.each do |submission|
      followed_submission_id_arr << submission.id
    end
    @submissions = current_user.followed_submissions
    @s_c = @submissions.count - 1
    if !current_user.google_calendars.empty?
      google_calendar = current_user.google_calendars.order(:id).first
      google_calenar_authentification(google_calendar)
      insert_calendar(google_calendar)
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client
      check_sync(google_calendar)
    end
  end

  def invited
    @groups = current_user.followers

    if !current_user.google_calendars.empty?
      google_calendar = current_user.google_calendars.order(:id).first
      google_calenar_authentification(google_calendar)
      insert_calendar(google_calendar)
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = client
      check_sync(google_calendar)
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email,
                                   :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

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
