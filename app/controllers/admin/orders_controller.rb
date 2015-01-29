class Admin::OrdersController < ApplicationController
  def index
    @completed_orders = Order.completed
    @paid_orders = Order.paid
    @cancelled_orders = Order.cancelled
    @ordered_orders = Order.ordered
    @orders = Order.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    redirect_to order_path(@order.id)
  end

  def filtered_orders
    @orders = Order.where(status: params[:status])
  end
end
