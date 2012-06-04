class CategoriesController < ApplicationController
  def home
  
    @category = Category.first
    @articles = @category.front_to_articles
    if can? :manage, Category
    redirect_to edit_category_path(@category)
    end
  
  end
  def index
    @categories = Category.excludes(Category.first.id)
  end
  def show
    @category = Category.find(params[:id])
    @articles = @category.front_to_articles
  end
  def edit 
    @category = Category.find(params[:id])
      @front_page_articles = @category.front_to_articles
    if @category.front_page_articles
    @articles = @category.articles.to_a - @category.front_to_articles
    else
    @articles = @category.articles.to_a
    end
  end
  def update 
    @category = Category.find(params[:id])
    if (@category.front_page_articles=params[:front_page_articles]) && @category.save
      flash[:success] = "Category successfully updated."
      if @category.front_page_articles
        @articles = @category.articles.to_a - @category.front_to_articles
      else
        @articles = @category.articles.to_a
      end
      @front_page_articles = @category.front_to_articles
      respond_to do |format| 
        format.html{redirect_to @category}
        format.js{render :layout=> false}
      end
    else
      flash[:error]="Something bad happened."
    end
    end
end
