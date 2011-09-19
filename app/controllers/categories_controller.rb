class CategoriesController < ApplicationController
  def home
  @category = Category.first
  @articles=[]
  if @category.front_page_articles
  @category.front_page_articles.each do |article|
    if !(article=="nil") then @articles<<Article.find(article) else @articles<<nil end
  end
  else
  @articles = nil
  end
  end
  def index
  @categories = Category.all
  end
  def show
  @category = Category.find(params[:id])
   if @category.front_page_articles

     @front_page_articles = []
       @category.front_page_articles.each do |article|
         if !(article=="nil")&&article then @front_page_articles<<Article.find(article) else @front_page_articles<<nil end
           end
             else

               @front_page_articles = nil
                 end

  end
  def edit 
  @category = Category.find(params[:id])
  @articles = @category.articles.all
  if @category.front_page_articles
  
  @front_page_articles = []
  @category.front_page_articles.each do |article| 
  if !(article=="nil")&&article then @front_page_articles<<Article.find(article) else @front_page_articles<<nil end
  end
  else 

  @front_page_articles = nil
  end
  end
  def update 
  @category = Category.find(params[:id])
  if (@category.front_page_articles=params[:front_page_articles]) && @category.save
    flash[:success] = "Category successfully updated."
    @front_page_articles = []
    @category.front_page_articles.each do |article|
    if !(article=="nil")&&article then @front_page_articles<<Article.find(article) else @front_page_articles<<nil end
    end

    respond_to do |format| 
      format.html{redirect_to @category}
      format.js{}
  

    end
  else
    flash[:error]="Something bad happened."
  end
  end
end
