class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    redirect_to order_path(@order.id)
  end
end
