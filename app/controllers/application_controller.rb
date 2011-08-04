class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def param_posted?(sym)
    request.post? and params[sym]

  end
end
