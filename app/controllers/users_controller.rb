class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index,:show, :edit, :update]
  before_filter :correct_user, :only => [:show, :edit, :update]
  before_filter :admin_user, :only=> :destroy

  def index
    @title = "All users"
    #@users = User.all
    @users = User.all.paginate :page => params[:page], :per_page => 10 #implements pagination with will_paginate gem 
  end

  def new
    @title="Sign Up"
   @user = User.new
  end

  def show
    @hide_edit_links = false
    @user = User.find(params[:id])
    @friends = @user.friends
    @requested_friends = @user.requested_friends
    @pending_friends = @user.pending_friends
    @title = @user.name
    @spec = @user.spec ||= Spec.new
    @faq = @user.faq ||= Faq.new
    @network = @user.network ||= Network.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the network, #{@user.name}"
      redirect_to @user
    else
      flash[:error] = "Signup not successful"
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id]) #already defined in correct_user filter 
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted successfully."
    redirect_to users_path
  end




  #private

    def authenticate
      deny_access unless signed_in?
    end

    #redirects signed in users who attempt unauthorized access.
    def correct_user
      @user = User.find(params[:id])
      #redirect_to (root_path) unless current_user?(@user)
      unless current_user?(@user)
        flash[:error] = "The requested page is unauthorized"
        #redirect_to(user_path(current_user))
        redirect_to root_path
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
