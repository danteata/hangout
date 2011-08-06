class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User",
              :foreign_key => "friend_id"
  validates :user_id, :presence => true
  validates :friend_id, :presence => true

  #returns true if friendship process ongoing or done
  def self.exists?(user, friend)
    not find_by_user_id_and_friend_id(user, friend).nil?
  end

  def self.request(user, friend) 
    unless user == friend or Friendship.exists?(user, friend)
      transaction do
        create(:user=>user, :friend=>friend, :status=>"pending")
        create(:user=>friend, :friend=>user, :status=>"requested")
      end
    end
  end

  #Accept a friend request
  def self.accept(user,friend)
    transaction do
      accepted_at = Time.now
      accept_one_side(user, friend, accepted_at)
      accept_one_side(friend, user, accepted_at)
    end
  end

  #Destroy a friendship or cancel a pending one
  def self.breakup(user, friend)
    transaction do
      destroy(find_by_user_id_and_friend_id(user, friend))
      destroy(find_by_user_id_and_friend_id(friend, user))

    end
  end

  private
    #Update the db with one side of an accepted friendship
  def self.accept_one_side(user, friend, accepted_at)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'accepted'
    request.accepted_at = accepted_at
    request.save!
  end
end


# == Schema Information
#
# Table name: friendships
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  friend_id    :integer
#  status       :string(255)
#  initiated_at :datetime
#  accepted_at  :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

