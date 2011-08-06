class ProfilesController < ApplicationController
  def index
  end

  #def show
    #@hide_edit_links = true #enables hiding of edit links in profile show view 
    #@user = User.find(params[:id])
    #if @user
      #@title = @user.name
    #else
      #flash[:notice] = "User not existent please signup"
      #redirect_to signup_path
    #end
  #end

  def show
    @hide_edit_links = true
    @user = User.find(params[:id])
    @friends = @user.friends
    @title = @user.name
    @spec = @user.spec ||=Spec.new
    @faq = @user.faq ||= Faq.new
  end
  def edit

  end
end
