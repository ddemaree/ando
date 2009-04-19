class SessionsController < ApplicationController
  protect_from_forgery :except => :create
  filter_parameter_logging :password
  
  def new
  end
  
  def create
    @user = User.authenticate(params[:session][:email],
                              params[:session][:password])
    if @user.nil?
      flash.now[:notice] = "Bad email or password."
      render :action => :new, :status => :unauthorized
    else
      sign_user_in(@user)
      flash[:notice] = "Signed in successfully."
      redirect_back_or root_url
    end
  end

  def destroy
    forget(current_user)
    reset_session
    flash[:notice] = "You have been signed out."
    redirect_to root_url
  end
  
private

  def url_after_create
    root_url
  end

  def url_after_destroy
    new_session_url
  end

end
