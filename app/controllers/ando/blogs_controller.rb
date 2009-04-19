class Ando::BlogsController < Ando::BaseController
  
  def index
    @blogs = Blog.find(:all)
  end

  def show
    @current_blog = Blog.find_by_basename(params[:id])
  end

  def edit
  end

end
