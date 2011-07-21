class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil? # if the user is not authenticated
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render :new
    else
#code for user sign in and redirection here! 
      sign_in user
      redirect_to user
    end
  end

  def destroy

  end

end
