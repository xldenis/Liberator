class CategoriesController < ApplicationController
  def index
  @categories = Category.all
  end

  def show
  @category = Category.find(params[:id])
  end
  def edit 
  @category = Category.find(params[:id])
  end
  def update 
  @category = Category.find(params[:id])
  if @category.update_attributes(params[:category]) && @category.save
    flash[:notice] = "Category successfully updated."
    redirect_to @category
  end
  end
end
