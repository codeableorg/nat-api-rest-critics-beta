class ApplicationController < ActionController::Base
  before_action :authenticate_user, except: %i[index show]
  helper_method %i[current_user logged_in?]

  def index; end

  def show; end

  def authenticate_user
    return if logged_in?

    flash[:notice] = "You need to be logged in to perform this action"
    redirect_to login_path
  end

  # Methods related to the session
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def log_in(user)
    session[:user_id] = user.id
    flash[:success] = "You are now logged in. Welcome to Critics #{user.username}!"
  end

  def log_out
    session.delete(:user_id)
    flash[:notice] = "Thanks for using Critics!"
  end
end
