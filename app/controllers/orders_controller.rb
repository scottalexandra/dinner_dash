class OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart.data.each do |item_id, quantity|
      item = Item.unscoped.find(item_id.to_i)
      item.add_quantity(quantity)
      @order.items << item
    end
  end

  def create
    if current_user
      @order = Order.new(user_id: current_user.id)
      line_items = @order.create_line_items(@cart.data)
      @order.line_items << line_items
      if @order.save
        flash[:notice] = "Your delicious food is on the way"
        redirect_to order_path(@order.id)
      else
        flash[:error] = "System error, unable to place order"
        redirect_to new_order_path
      end
    else
      flash[:notice] = "Please login or signup to continue with checkout"
      redirect_to :back
    end
  end

  def index
    @orders = User.find(current_user.id).orders
  end

  def show
    @order = Order.find(params[:id])
  end
end
