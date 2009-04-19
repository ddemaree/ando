class Admin::ServicesController < ApplicationController::Admin
  
  def index
    render :layout => false, :content_type => Mime::ATOM
  end
  
end
