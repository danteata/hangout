module FriendshipsHelper

  #return an appropriate friendship status message
  def friendship_status(user, friend)
    friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
    return "#{friend.name} is not your friend yet." if friendship.nil?
    case friendship.status
    when 'requested'
      "#{friend.name} would like to connect to you."
    when 'pending'
      "Friend requested from #{friend.name}"
    when 'accepted'
      "#{friend.name} is your friend."
    end

  end

  #displays which action to take depending on friendship status
  def friendship_action(user, friend)
    #return "me" if User.is_same?(user, friend)
    return "me" if current_user?(friend)
    friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
    return link_to "Add friend", {:controller =>"friendships",
      :action =>"initiate", :id => friend.id},
      :confirm =>"Add #{friend.name}?" if friendship.nil? 

    case friendship.status
    when 'requested'
      "awaiting ur approval"
    when 'pending'
      "sent request"
    end
  end

  #returns an array of all mutual friends of current user and user whose profile he is viewing
  def mutual_friends(user)
    mutual = []
    user.friends.each do |friend|
      #gathering mutual friends
      if current_user.friends.any? and current_user.friends.include?(friend) and !current_user?(user)
      #unless current_user.friends.empty? or !current_user.friends.include?(friend) 
        mutual << friend
      end

      #return mutual
    end
  end

  #def mutual_friends(user, friend)
  #friend.friends.each do |friend| #loop through friends list of friends and add all common friends. 
  #mutual = []
  ##gathering mutual friends
  #unless user.friends.empty? or !user.friends.include?(friend) 
  #mutual << friend
  #end

  #return mutual
  #end
  #end
end
