class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    user_info = request.env["omniauth.auth"]

    @user = User.find_by(uid: user_info.uid) || create_user(user_info)

    if @user.save
      log_in(@user)
      redirect_to @user
    else
      flash[:alert] = "Please complete your information to sign up"
      render "users/new"
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Thanks for using Critics! See you!"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :birth_date, :first_name, :last_name, :uid)
  end

  def create_user(user_info)
    user = User.new

    user.uid = user_info.uid
    user.email = user_info.info.email
    user.username = user_info.info.nickname
    user.birth_date = "1900-01-01"
    name = user_info.info.name
    user.first_name = name.split.first
    user.last_name = name.split.last

    user
  end
end
