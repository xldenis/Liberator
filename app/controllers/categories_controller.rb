class CategoriesController < ApplicationController
  load_and_authorize_resource :find_by => :slug
  def home

    @category = Category.first
    @articles = @category.front_to_articles
    if can? :manage, Category
      redirect_to edit_category_path(@category)
    end

  end
  def index
    redirect_to :root
    #@categories = Category.excludes(Category.first)
  end
  def show
    @articles = @category.front_to_articles
  end
  def edit
    @front_page_articles = @category.front_to_articles
    if @category.front_page_articles
      @articles = @category.articles.where(:published=> true).to_a - @category.front_to_articles
    else
      @articles = @category.articles.where(:published => true).to_a
    end
  end
  def update
    if (@category.front_page_articles=params[:front_page_articles]) && @category.save
      flash[:success] = "Category successfully updated."
      if @category.front_page_articles
        @articles = @category.articles.where(:published => true).to_a - @category.front_to_articles
      else
        @articles = @category.articles.where(:published => true).to_a
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
