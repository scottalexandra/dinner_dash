class UsersController < ApplicationController
# before_action :current_user?, only: [:show]

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
      redirect_to new_user_path, error: "Invalid Login Credentials"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :display_name, :password)
  end

  # def current_user?
  #   unless current_user[:id] == params[:id].to_i
  #     redirect_to root_path
  #   end
  # end
end
