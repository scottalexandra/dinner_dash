class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    redirect_to not_found_path
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  helper_method :current_user
end
