class ProfilesController < ApplicationController
  before_filter :authenticate
  before_filter :check_profile_privacy, :only =>[:show] #checks if user's profile can be viewed by requesting user 

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
    render "users/show" #profile view and users view are similar (just without edit links) 
  end

  def edit

  end

  #private

  #checks for user's permission and performs appropriate action
  def check_profile_privacy
    @user =User.find(params[:id])

    unless current_user?(@user) or can_view?(@user)
      #since there will be no redirection for now flash.now I used
      flash.now[:notice] = "#{@user.name} only allows friends to view profile..last warning"
    end
    #redirect_to profile_path(current_user), :notice =>"can't view" unless can_view?
  end

  #returns true if user has permission to view the requested friend's profile
  def can_view?(user)
    @user = user
    @preference = @user.preference ||= Preference.new

    #a user's profile can be viewed if he has no restriction(all ends with ll) on it or otherwise if requester is a friend.
    @preference.profile_view.end_with? "ll" || @user.friends.include?(current_user)
  end

end
