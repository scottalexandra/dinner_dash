class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    if item.save
      flash[:notice] = "Successfully Created"
      redirect_to item_path(item)
    else
      flash[:error] = "Invalid input"
      redirect_to new_admin_item_path
    end
  end

  def item_params
    params.require(:item).permit(:title, :description, :price)
  end
end
