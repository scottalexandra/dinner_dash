class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize! :read, @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: "User created successfully."
    else
      redirect_to new_user_path, error: "Invalid Credentials"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :display_name, :password)
  end
end
