class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_cart

  rescue_from CanCan::AccessDenied do
    redirect_to not_found_path
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user ||= Admin.find(session[:admin_id]) if session[:admin_id]
    @current_user
  end

  # def current_admin
  #   @current_user ||= Admin.find(session[:admin_id]) if session[:admin_id]
  # end


  helper_method :current_user
end
