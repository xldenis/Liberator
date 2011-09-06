class ArticlesController < ApplicationController
  load_and_authorize_resource
  def index
    @article = Article.all
  end
  def create
    @article = current_user.articles.new
    if @article.update_attributes(params[:article]) && @article.save
      flash[:notice]= "Article successfully created."
      respond_to do |format|
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
    debugger
  end

  def edit
    @article = Article.find(params[:id])
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
      put "So far so good"
      if @article.destroy
        flash[:notice] = "Article deleted."
        respond_to do |format|
        format.html{redirect_to articles_path}
        format.js{}
        end
      else
        flash[:error] = "Try Again."
        redirect_to :back
      end
  end
end
