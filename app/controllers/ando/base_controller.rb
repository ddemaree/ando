class Ando::BaseController < ApplicationController
  layout :select_layout
  
  rescue_from ActiveRecord::RecordInvalid do |exception|
    flash.now[:alert] = "There appears to be a problem."
    render :action => "edit"
  end
  
  def index
  end
  
  def current_blog
    @current_blog ||= Blog.find_by_basename(params[:blog_id])
  end
  helper_method :current_blog
  
  def section_name
    controller_name.to_sym
  end
  helper_method :section_name
  
  def system_message
    flash[:message] || flash[:alert] || params[:system_message]
  end
  helper_method :system_message

  def select_layout
    "ando/#{!current_blog.nil? ? "blog" : "global"}"
  end

end
