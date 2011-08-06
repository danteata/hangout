class FriendshipsController < ApplicationController
  before_filter :setup_friends

  def initiate
    #@user = current_user
    #@friend = User.find(params[:id])
    Friendship.request(@user, @friend)
    #UserMailer.friend_request(@user, @friend).deliver
    flash[:notice] = "Friend request sent"
    redirect_to profile_path(@friend)

  end

  def accept
    if @user.requested_friends.include?(@friend)
      Friendship.accept(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} accepted!"
    else
      flash[:notice] = "No friendship request from #{@friend.name}"
    end
    redirect_to profile_path(@user)
  end

  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} declined!"
    else
      flash[:notice] = "No friendship request from #{@friend.name}"
    end
    redirect_to profile_path(@user)
  end
  
  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} cancelled!"
    else
      flash[:notice] = "No request for friendship with #{@friend.name}"
    end
    redirect_to profile_path(@user)
  end

  def delete
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} deleted!"
    else
      flash[:notice] = "You are not yet friends with #{@friend.name}"
    end
    redirect_to profile_path(@user)
  end

  private 

  def setup_friends
    @user = current_user
    @friend = User.find(params[:id])
  end

  
end
