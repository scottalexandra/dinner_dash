class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    authorize! :new, @item
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
    authorize! :edit, @item
  end

  def update
    @item = Item.find(params[:id])
    authorize! :update, @item
    @item.update(item_params)
    params[:item][:categories].shift
    params[:item][:categories].each do |cat_id|
      @item.categories << Category.find(cat_id.to_i)
    end
    flash[:notice] = "Successfully Updated"
    redirect_to item_path(@item)
  end

  def destroy
    @item = Item.find(params[:id])
    # authorize! :destroy, @item
    @item.update(status: "hidden")
    flash[:notice] = "Item Successfully Hidden"
    redirect_to categories_path
  end

  def show
    @item = Item.hidden.find(params[:id])
    @item.update(status: "show")
    flash[:notice] = "Item Successfully Revealed"
    redirect_to categories_path
  end

  private

  def item_params
    params.require(:item).permit(:title,
                                 :description,
                                 :price,
                                 :categories,
                                 :image)
  end
end
