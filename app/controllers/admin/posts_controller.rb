class Admin::PostsController < ApplicationController::Admin
  
  def index
    @search = Postable.new_search(params[:search])
    @posts, @posts_count = @search.all, @search.count
  end

end
