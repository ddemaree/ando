# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  before_filter :set_time_zone, :set_current_author
  
  class Admin < self
    before_filter :login_required
    layout 'admin'
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def set_time_zone
    Time.zone = "Central Time (US & Canada)"
  end
  
  def set_current_author
    Postable.current_user = self.current_user
  end
  
end