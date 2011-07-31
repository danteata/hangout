class ProfilesController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    if @user
      @title = @user.name
    else
      flash[:notice] = "User not existent please signup"
      redirect_to signup_path
    end
  end

  def edit

  end
end
