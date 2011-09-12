class CategoriesController < ApplicationController
  def index
  @categories = Category.all
  @articles = Article.find(@categories.first.front_page_articles) if @categories.first.front_page_articles
  end

  def show
  @category = Category.find(params[:id])
  end
  def edit 
  @category = Category.find(params[:id])
  @articles = @category.articles.all
  if @category.front_page_articles
  
  @front_page_articles = []
  @category.front_page_articles.each do |article|
  
  if !(article=="nil") then @front_page_articles<<Article.find(article) else @front_page_articles<<nil end
  end
  else 

  @front_page_articles = nil
  end
  end
  def update 
  @category = Category.find(params[:id])
  if (@category.front_page_articles=params[:front_page_articles]) && @category.save
    flash[:success] = "Category successfully updated."
    
    respond_to do |format| 
      format.html{redirect_to @category}
      format.js{render :nothing => true}
    end
  end
  end
end
