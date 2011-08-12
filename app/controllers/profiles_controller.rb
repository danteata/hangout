class ProfilesController < ApplicationController
  before_filter :authenticate
  before_filter :check_profile_privacy, :only =>[:show] #checks if user's profile can be viewed by requesting user 

  def index
  end

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

  private

  #checks for user's permission and performs appropriate action
  def check_profile_privacy
    @user =User.find(params[:id]) #the user whose profile is to be viewed 

    unless can_view?(@user) or current_user?(@user)
      flash[:notice] = "#{@user.name} only allows friends to view profile.
       You can send a request to be friends on hangout."
      redirect_to profile_path(current_user) #redirect user to own profile if requested profile is inaccessible 
    end
  end

  #returns true if user has permission to view the requested friend's profile
  def can_view?(user)
    @user = user
    @preference = @user.preference ||= Preference.new

    #a user's profile can be viewed if he has no restriction(all ends with ll) on it or otherwise if requester is a friend.
     #@preference.profile_view.end_with? "ll" || @user.friends.include?(current_user)
    @user.friends.include?(current_user) || @preference.profile_view.end_with? ("ll")
  end

end
