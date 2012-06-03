class ArticlesController < ApplicationController
  load_and_authorize_resource
  def index
    @article = Article.all
    @article_months = @article.group_by { |a| a.created_at.beginning_of_month }
  end
  def create
    @article = current_user.articles.new
   temp_params = params[:article].reject {|key,value| key == "category_ids"}
    if @article.update_attributes(temp_params) && @article.save
      @article.categories=[Category.find(params[:article][:category_ids])]
      @article.save
     flash[:success]= "Article successfully created."
      respond_to do |format|
       format.html{if params[:article][:image]||params[:article][:remote_image_url] then redirect_to crop_article_path(@article) else redirect_to @article  end } 
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
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    temp_params = params[:article].reject {|key,value| key == "category_ids"}
    @article.categories=[Category.find(params[:article][:category_ids])]
   if @article.update_attributes!(temp_params)
      flash[:notice] = "Article Successfully Updated."
      respond_to do |format|
        format.html{if params[:article][:image]||params[:article][:remote_image_url] then redirect_to crop_article_path(@article) else redirect_to @article  end } 
        format.js{}
      end
    else
      flash[:error] = "Something is wrong."
      redirect_to :edit
  end
  end
  def destroy
    @article = Article.find(params[:id])
    
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
  @article = Article.find(params[:id])
  if !@article.image
    flash[:notice] = "Try uploading an image first.."
    redirect_to article_edit_path(@article)
  end
  end
  def crop_update
    @article = Article.find(params[:id])
    @article.crop_x = params[:article]["crop_x"]
    @article.crop_y = params[:article]["crop_y"]
    @article.crop_h = params[:article]["crop_h"]
    @article.crop_w = params[:article]["crop_w"]
    @article.save
    redirect_to @article
  end
end
