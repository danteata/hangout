class ProfilesController < ApplicationController
  before_filter :authenticate
  #before_filter :check_profile_privacy, :only =>[:show] #checks if user's profile can be viewed by requesting user 

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
    @requested_friends = @user.requested_friends
    @pending_friends = @user.pending_friends
    @title = @user.name
    @spec = @user.spec ||=Spec.new
    @faq = @user.faq ||= Faq.new
    @network = @user.network ||= Network.new
  end

  def edit

  end

  private

  #checks for user's permission and performs appropriate action
  def check_profile_privacy
    flash[:notice] = "#{current_user} only allows friends to view profile"
    redirect_to profile_path(current_user), :notice =>"can't view" unless can_view?
  end

  #returns true if user has permission to view the requested friend's profile
  def can_view?
    @preference = @user.preference ||= Preference.new
    !(@preference == "friends" and !@user.friends.include?(current_user))
  end

end
