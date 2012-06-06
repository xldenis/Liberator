class ArticlesController < ApplicationController
  load_and_authorize_resource :find_by => :slug
  def index
    @article = Article.all
    @article_months = @article.desc(:created_at).group_by { |a| a.created_at.beginning_of_month }
  end
  def create
    @article = current_user.articles.new
   temp_params = params[:article].reject {|key,value| key == "category_ids"}
    debugger
    if @article.update_attributes(temp_params) && @article.save
      @article.categories=[Category.find(params[:article][:category_ids])]
      @article.save
      
     flash[:success]= "Article successfully created."

      respond_to do |format|
       format.html{if params[:article][:image] then redirect_to crop_article_path(@article) else redirect_to @article  end } 
       format.js{redirect_to @article}
      end
    else
      flash[:error]="Check yo self fool." 
      respond_to do |format|
        format.js{}
        format.html{}
      end
    end
  end

  def new
    @article = Article.new
  end

  def show
  end

  def edit
  end

  def update
    temp_params = params[:article].reject {|key,value| key == "category_ids"}
    @article.categories=[Category.find(params[:article][:category_ids])]
   if @article.update_attributes!(temp_params)
      flash[:notice] = "Article Successfully Updated."
      respond_to do |format|
        format.html{if params[:article][:image] then redirect_to crop_article_path(@article) else redirect_to @article  end } 
        format.js{}
      end
    else
      flash[:error] = "Something is wrong."
      redirect_to :edit
  end
  end
  def destroy
    
      if @article.destroy
        flash[:notice] = "Article deleted."
        respond_to do |format|
        format.html{redirect_to articles_path}
        format.js{@articles = Article.all}
        end
      else
        flash[:error] = "Try Again."
        redirect_to :back
      end
  end
  def crop
  if !@article.image
    flash[:notice] = "Try uploading an image first.."
    redirect_to article_edit_path(@article)
  end
  end
  def crop_update
    @article.crop_x = params[:article]["crop_x"]
    @article.crop_y = params[:article]["crop_y"]
    @article.crop_h = params[:article]["crop_h"]
    @article.crop_w = params[:article]["crop_w"]
    @article.save
    redirect_to @article
  end
  def publish
    if can? :publish, Article 
      @article = Article.find_by_slug(params[:id])
      @article.published = !@article.published
      if @article.save
        render :nothing => true
      else
        render :nothing => true
      end
    end
  end
end
