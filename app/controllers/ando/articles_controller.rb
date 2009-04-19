class Ando::ArticlesController < ApplicationController::Admin
  
  def index
    @articles = Article.paginate(:all, :per_page => 50, :page => params[:page])
  end
  
  def show
    @article = Article.find(params[:id])
    render :edit
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new(params[:article])
    render :edit
  end

end
