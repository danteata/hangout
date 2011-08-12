class NetworksController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :except =>[:index, :update]

  def index
    @title = "networks"
    #redirect_to users_path
  end

  def edit

    @title = "Edit Networks"
    @user = current_user
    @network = @user.network ||= Network.new

  end

  def update
    @user = current_user
    @network = @user.network ||= Network.new

    if @network.update_attributes(params[:network])
      flash[:success] = "Changes saved successfully"
      redirect_to @user
    else
      @title = "Edit Networks"
      render 'edit'
    end

  end

  #private

  ##redirects signed in users who attempt unauthorized access.
  #def correct_user
    #@user = User.find(params[:id])
    ##redirect_to (root_path) unless current_user?(@user)
    #unless current_user?(@user)
      #flash[:error] = "The requested page is unauthorized"
      #redirect_to(user_path(current_user))
      ##redirect_to root_path
    #end
  #end

end
