# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  class Admin < self
    before_filter :authenticate
    layout 'admin'
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  helper_method :current_user
  helper_method :signed_in?

  hide_action :current_user, :signed_in?
  
  def current_user
    @_current_user ||= (user_from_cookie || user_from_session)
  end

  def signed_in?
    !current_user.nil?
  end
  
protected

  def authenticate
    deny_access and return unless signed_in?
    Ando.current_user = current_user
  end
  
  def user_from_session
    if session[:user_id]
      return nil  unless user = User.find_by_id(session[:user_id])
      return user if user#     user.email_confirmed?
    end
  end

  def user_from_cookie
    # if token = cookies[:remember_token]
    #       return nil  unless user = User.find_by_token(token)
    #       return user if     user.remember?
    #     end
    return nil
  end
  
  def store_location
    session[:return_to] = request.request_uri if request.get?
  end

  def deny_access(flash_message = nil, opts = {})
    store_location
    flash[:failure] = flash_message if flash_message
    redirect_to new_session_url
  end
  
  def sign_user_in(user)
    sign_in(user)
  end

  def sign_in(user)
    if user
      session[:user_id] = user.id
    end
  end
  
  def redirect_back_or(default)
    session[:return_to] ||= params[:return_to]
    if session[:return_to]
      redirect_to(session[:return_to])
    else
      redirect_to(default)
    end
    session[:return_to] = nil
  end

  def redirect_to_root
    redirect_to root_url
  end
  
  
end
