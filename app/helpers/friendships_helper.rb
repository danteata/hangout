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


  #returns a mutual friends list or an empty array if there are none 
  def mutual_friends user
    unless current_user.friends.empty? or user.friends.empty?
      #returns the intersection of the 2 arrays which represents mutual friends
      user.friends & current_user.friends
    else
      []
    end
  end

end
