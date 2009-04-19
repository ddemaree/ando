class WebsiteController < ApplicationController

  def show
    request_uri = params[:wildcard].join("/")
    render :text => current_blog.render(request_uri)
  end
  
protected

  def current_blog
    @blog ||= Blog.find(:first)
  end

end
