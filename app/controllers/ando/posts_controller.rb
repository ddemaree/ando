class Ando::PostsController < ApplicationController::Admin
  
  def index
    @posts = Post.paginate(:all, :per_page => 30, :page => params[:page])
  end

end
