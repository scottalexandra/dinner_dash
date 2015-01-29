class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    admin = Admin.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      assign_session_id(user, :user_id)
    elsif admin && admin.authenticate(params[:session][:password])
      assign_session_id(admin, :admin_id)
    else
      flash[:error] = "Invalid Login Credentials"
      redirect_to root_path
    end
  end

  def destroy
    session[:admin_id] = nil
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully Logged Out"
  end

  def assign_session_id(user_type, id)
    session[id] = user_type.id
    flash[:notice] = "Successfully Logged In"
    redirect_to root_path
  end
end
