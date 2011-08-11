class FriendshipsController < ApplicationController
  before_filter :authenticate, :setup_friends

  def initiate
    Friendship.request(@user, @friend)
    UserMailer.friend_request(@user, @friend).deliver
    flash[:success] = "Friend request sent to #{@friend.email}"
    redirect_to profile_path(@friend)

  end

  def accept
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:success] = "Friendship with #{@friend.name} accepted!"
    else
      flash[:error] = "No friendship request from #{@friend.name}"
    end
    redirect_to profile_path(@user)
  end

  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:success] = "Friendship with #{@friend.name} declined!"
    else
      flash[:error] = "No friendship request from #{@friend.name}"
    end
    redirect_to profile_path(@user)
  end
  
  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:success] = "Friendship with #{@friend.name} cancelled!"
    else
      flash[:error] = "No request for friendship with #{@friend.name}"
    end
    redirect_to profile_path(@user)
  end

  def delete
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:success] = "Friendship with #{@friend.name} deleted!"
    else
      flash[:error] = "You are not yet friends with #{@friend.name}"
    end
    redirect_to profile_path(@user)
  end

  private 

  #initialize current user and friend
  def setup_friends
    @user = current_user
    @friend = User.find(params[:id])
  end

  
end
