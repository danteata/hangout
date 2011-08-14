class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index,:show, :edit, :update] #non members can only sign up to platform 
  before_filter :correct_user, :only => [:edit, :update] #member actions require current_user 
  before_filter :admin_user, :only=> :destroy

  #displays a view of all users of the platform
  def index
    @title = "All users"
    #@users = User.all
    @users = User.all.paginate :page => params[:page], :per_page => 10 #implements pagination with will_paginate gem 
    respond_to do |format|
      format.html {render :index}
      format.js
    end
  end

  #renders a new view to sign up new users
  def new
    @title="Sign Up"
   @user = User.new
  end

  def show
    @user = User.find(params[:id])
    #edit links will show if user is viewing his own profile
    @hide_edit_links = true unless current_user?(@user)
    @friends = @user.friends
    @requested_friends = @user.requested_friends
    @pending_friends = @user.pending_friends
    @title = @user.name
    @spec = @user.spec ||= Spec.new
    @faq = @user.faq ||= Faq.new
    @network = @user.network ||= Network.new
    @preference = @user.preference ||= Preference.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user #assigns @user tp current_user 
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

  def friends

    @user = User.find(params[:id])
    @friends = @user.friends.paginate :page => params[:page]

    if @friends.empty?
      flash[:notice] = "There are no friends to display"
      respond_to do |format|
        format.html {redirect_to profile_path(@user)}
        format.js
      end
      #redirect_to profile_path(@user)
    end

    respond_to do |format|
      format.html
      format.js
    end
    #redirect_to profile_path(@user)
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
      redirect_to(user_path(current_user))
      #redirect_to root_path
    end
  end
    #redirects signed in users who attempt unauthorized access.
    #def correct_user
      #@user = User.find(params[:id])
      #redirect_to (root_path) unless current_user?(@user)
      #unless current_user?(@user)
        #flash[:error] = "The requested page is unauthorized"
        #redirect_to(user_path(current_user))
        #redirect_to root_path
      #end
    #end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
