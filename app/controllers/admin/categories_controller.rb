class Admin::CategoriesController < ApplicationController
  def new
    @category = Category.new
    authorize! :new, @category
  end

  def create
    category = Category.new(category_params)
    if category.save
      flash[:notice] = "Successfully Created"
      redirect_to category_path(category)
    else
      flash[:error] = "Invalid input"
      redirect_to new_admin_category_path
    end
  end

  def edit
    @category = Category.find(params[:id])
    authorize! :edit, @category
  end

  def update
    @category = Category.find(params[:id])
    authorize! :update, @category
    @item = Item.find(params[:item_id])
    @category.items.delete(@item)
    flash[:notice] = "Successfully Removed Item from #{@category.name}"
    redirect_to categories_path
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
