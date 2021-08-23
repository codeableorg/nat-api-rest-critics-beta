class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new; end

  def create
    if params[:provider]
      create_from_provider
    else
      create_from_email
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end

  def create_user
    User.create do |user|
      info = auth_hash.info
      user.uid = auth_hash.uid
      user.username = info.nickname
      user.email = info.email
      user.first_name = info.first_name
      user.last_name = info.last_name
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def create_from_provider
    @user = User.find_by(uid: auth_hash.uid)
    if @user
      log_in(@user)
      redirect_to @user
    else
      @user = create_user
      log_in(@user)
      flash[:alert] = "Update your password"
      redirect_to edit_user_path(@user)
    end
  end

  def create_from_email
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      log_in(user)
      redirect_to user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end
end
