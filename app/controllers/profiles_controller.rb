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

    #gets all of a user's friends and retrieves their ids.
    #profile_friends_ids = @user.friends.map {|friend| friend.id}
    profile_friends_ids = @user.friends.map(&:id).push(@user.id).join(", ")
    # a status feed is posted by a user unto his own wall.and only friends feeds are retrieved.
    @status = Post.where "poster_id = user_id and poster_id = ?", @user

    @friend_feeds = Post.where ("poster_id = user_id AND poster_id IN (#{profile_friends_ids})")
    @wall_posts = Post.where "user_id = #{@user.id} AND poster_id IN (#{profile_friends_ids})" #wall posts now includes user's own posts 

    #visitors of a profile see all posts written by profile owner's friends plus status updates.
    @posts = @status.nil? ? [] : @status.paginate(:page=>params[:page])
    #@posts = @user.posts.paginate(:page => params[:page])
    #@microposts = @user.microposts.paginate(:page => params[:page])
    #render "users/show" #profile view and users view are similar (just without edit links) 
  end

  def edit

  end

  #def profile_feed
  ##gets all of a user's friends and retrieves their ids.
  #profile_friends_ids = @user.friends.map {|friend| friend.id}
  ## a status feed is posted by a user unto his own wall.and only friends feeds are retrieved.
  #feed = Micropost.where(:poster_id=> profile_friends_id.push(@user.id) AND
  #:poster_id =?, :user_id)
  #Micropost.where("poster_id IN #{profile_friends_id.push(@user.id)} AND poster_id =user_id")
  #end

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
    #@user.friends.include?(current_user) || @preference.profile_view.end_with? ("ll")
    @user.friends.include?(current_user) || @preference.profile_view == "All" || @preference.profile_view == "all" 
  end

end
