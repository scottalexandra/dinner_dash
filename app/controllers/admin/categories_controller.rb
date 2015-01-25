class Admin::CategoriesController < ApplicationController
  def new
    @category = Category.new
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

  def category_params
    params.require(:category).permit(:name)
  end
end
