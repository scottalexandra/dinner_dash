class OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart.data.each do |item_id, quantity|
      item = Item.find(item_id.to_i)
      item.add_quantity(quantity)
      @order.items << item
    end
  end

  def create
    if current_user
      @order = Order.new(user_id: current_user.id)
      params[:item_ids].each do |item_id|
        item = Item.find(item_id.to_i)
        @order.items << item
      end
      if @order.save
        flash[:notice] = "Your delicious food is on the way"
        redirect_to order_path(@order.id)
      else
        flash[:error] = "System error, unable to place order"
        redirect_to new_order_path
      end
    else
      flash[:notice] = "Please login or signup to continue with checkout"
      redirect_to login_path
    end
  end

  def show
  end
end
