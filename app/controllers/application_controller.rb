class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in!(user)
    @current_user = user
    session[:session_token] = user.session_token
    redirect_to new_session_url
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def require_log_in
    redirect_to new_session_url unless logged_in?
  end

  def require_log_out
    redirect_to users_url if logged_in
  end

end
