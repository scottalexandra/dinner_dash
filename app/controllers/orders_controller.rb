class OrdersController < ApplicationController
  def new
    @items = []
    @cart.data.each do |item_id, quantity|
      item = Item.find(item_id.to_i)
      item.add_quantity(quantity)
      @items << item
    end
  end

  def create
    if current_user.nil?
      redirect_to login_path
      flash[:notice] = "Please login or signup to continue with checkout"
    end
  end

  # def order_params
    # params.require(:order).permit(:user_id)
  # end
end
