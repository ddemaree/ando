class Ando::LinksController < Ando::BaseController
  def index
    @links = current_blog.links.find(:all)
  end
  
  def new
    @link = current_blog.links.build(params[:link])
    render :action => 'edit'
  end
  
  def create
    @link = current_blog.links.build(params[:link])
    @link.save!
    flash[:message] = "The link '#{@link}' was created."
    redirect_to :action => 'edit', :id => @link
  end

  def edit
    @link = current_blog.links.find(params[:id])
  end

end
