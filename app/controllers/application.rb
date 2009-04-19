# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8fbc0907f23cf0268cdf3ec63b59e223'
  
  
protected

  # def current_blog
  #   @current_blog ||= Blog.find(params[:blog_id]) rescue nil
  # end
  # helper_method :current_blog
  
end
