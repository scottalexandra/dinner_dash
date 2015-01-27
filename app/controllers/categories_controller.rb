class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @hidden_items = Item.hidden
  end

  def show
    @category = Category.find(params[:id])
  end
end
