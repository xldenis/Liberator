class CategoriesController < ApplicationController
  def index
  @categories = Category.all
  @articles = Article.find(@categories.first.front_page_articles)
  end

  def show
  @category = Category.find(params[:id])
  end
  def edit 
  @category = Category.find(params[:id])
  @articles = @category.articles.all
  if @category.front_page_articles
  @front_page_articles = Article.find(@category.front_page_articles)
  else 
  @front_page_articles = nil
  end
  end
  def update 
  @category = Category.find(params[:id])
  if @category.update_attributes(params[:category]) && @category.save
    flash[:notice] = "Category successfully updated."
    redirect_to @category
  end
  end
end
