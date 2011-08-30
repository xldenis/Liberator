class ArticlesController < ApplicationController
  load_and_authorize_resource
  def index
    @article = Article.all
  end
  def create
    @article = current_user.articles.new
    if @article.update_attributes(params[:article]) && @article.save
      flash[:notice]= "Article successfully created."
      redirect_to @article
    else
      flash[:error]="Check yo self fool." 
      redirect_to :back
    end
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Artcile.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article = Article.update_attributes(params[:article])
      flash[:notice] = "Article Successfully Updated."
      redirect_to @article
    else
      flash[:error] = "Something is wrong."
      redirect_to :edit
  end
  end
  def destroy
    @article = Article.find(params[:id])
      if @article.destroy
        flash[:notice] = "Article deleted."
        redirect_to articles
      else
        flash[:error] = "Try Again."
        redirect_to :back
      end
  end
end
