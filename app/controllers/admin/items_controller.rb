class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    item = Item.new(item_params)
    params[:item][:categories].shift
    params[:item][:categories].each do |cat_id|
      item.categories << Category.find(cat_id.to_i)
    end
    if item.save
      flash[:notice] = "Successfully Created"
      redirect_to item_path(item)
    else
      flash[:error] = "Invalid input"
      redirect_to new_admin_item_path
    end
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    params[:item][:categories].shift
    params[:item][:categories].each do |cat_id|
      @item.categories << Category.find(cat_id.to_i)
    end
    flash[:notice] = "Successfully Updated"
    redirect_to item_path(@item)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :categories, :image)
  end
end
