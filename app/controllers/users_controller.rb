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
      redirect_to user_path(@user.id), alert: "User created successfully."
    else
      redirect_to new_user_path, alert: "Error creating user."
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
