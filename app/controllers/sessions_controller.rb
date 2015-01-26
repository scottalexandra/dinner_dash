class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:notice] = "Successfully Logged In"
        redirect_to root_path
      else
        flash[:error] = "Invalid Login Credentials"
        render :new
      end
    elsif admin = Admin.find_by(email: params[:session][:email])
      if admin && admin.authenticate(params[:session][:password])
        session[:admin_id] = admin.id
        flash[:notice] = "Successfully Logged In"
        redirect_to root_path
      else
        flash[:error] = "Invalid Login Credentials"
        render :new
      end
    else
      flash[:error] = "Invalid Login Credentials"
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully Logged Out"
  end
end
