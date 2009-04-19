class Ando::ArticlesController < Ando::BaseController
  
  def index
    @articles = current_blog.articles.find(:all, :order => "created_at DESC, id DESC")
  end

  def new
    @article = current_blog.articles.build(params[:article])
    render :action => "edit"
  end
  
  def create
    @article = current_blog.articles.build(params[:article])
    @article.save!
    flash[:message] = "The article '#{@article}' was created."
    redirect_to :action => 'edit', :id => @article
  end

  def edit
    @article = current_blog.articles.find_by_basename!(params[:id])
  end
  
  def update
    @article = current_blog.articles.find_by_basename!(params[:id])
    @article.update_attributes!(params[:article])
    flash[:message] = "Your changes to the article '#{@article}' were saved."
    redirect_to :action => 'edit', :id => @article
  end

end
