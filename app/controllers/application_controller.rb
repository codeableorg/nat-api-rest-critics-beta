class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :authenticate_user, except: %i[index show]

  def index; end

  def show; end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def log_in(user)
    session[:user_id] = user.id
    flash[:success] = "You are now logged in. Welcomes to Critics #{user.username}!"
  end

  def authenticate_user
    return if logged_in?

    flash[:notice] = "You need to be logged in to perform this action"
    redirect_to root_path
  end
end
