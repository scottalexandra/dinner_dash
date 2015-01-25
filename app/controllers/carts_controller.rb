class CartsController < ApplicationController
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.data
    redirect_to categories_path
  end

  def destroy
    @cart.remove_item(params[:item_id])
    redirect_to categories_path
  end
end
