class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def param_posted?(sym)
    request.post? and params[sym]

  end

  def authenticate
    deny_access unless signed_in?
  end

  #redirects signed in users who attempt unauthorized access.
  def correct_user
    @user = User.find(params[:id])
    #redirect_to (root_path) unless current_user?(@user)
    unless current_user?(@user)
      flash[:error] = "The requested page is unauthorized"
      redirect_to(user_path(current_user))
      #redirect_to root_path
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
