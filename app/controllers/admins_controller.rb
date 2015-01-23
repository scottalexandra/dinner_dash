class AdminsController < ApplicationController
  def show
    @admin = Admin.find(params[:id])
    authorize! :read, @admin
  end
end
