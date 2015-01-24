class CartsController < ApplicationController
  def create
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.data
    redirect_to categories_path
  end
end