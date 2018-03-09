class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to you_path
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  #oauth認証
  def create_from_oauth
    logger.debug("デバッグ：#{request}")
    auth = request.env["omniauth.auth"]
    logger.debug("デバッグ：#{auth}")
    #すでにauthorizationがあるのか確認
    unless @auth = Authorization.find_by(provider: auth["provider"], uid: auth["uid"])
      #なければ
      #1.ユーザーそもそもユーザーがいるのかを確認
      #2.ユーザーがいればauthorizationを作成して、userとヒモづけ
      #3.ユーザーがいなければuser作成して、authorizationと紐付け
      if user = User.find_by(email: auth["info"]["email"])
        Authorization.create_from_oauth(auth, user)
        logger.debug("ユーザーいました")
      else
        user = User.new(name: auth["info"]["name"], email: auth["info"]["email"])
        user.save(validate: false)
        Authorization.create_from_oauth(auth, user)
        logger.debug("ユーザー作成しました")
      end
    end
    user ||= User.find(@auth.user_id)
    log_in(user)
    remember(user)
    redirect_to you_path
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
