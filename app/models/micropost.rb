class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :content, :presence => true,
    :length => {:maximum => 255}
  validates :user_id, :presence => true

  default_scope :order =>"microposts.created_at DESC" #display most current posts first 

end
