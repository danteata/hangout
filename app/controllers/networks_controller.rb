class NetworksController < ApplicationController
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

end
