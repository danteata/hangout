class Post < ActiveRecord::Base
  attr_accessible :content, :poster_id 

  belongs_to :user
  belongs_to :poster, :class_name => "User", :foreign_key => "poster_id"
  has_many :comments, :dependent => :destroy

  validates :content, :presence => true,
    :length => {:maximum => 255}
  validates :user_id, :presence => true
  validates :poster_id, :presence => true

  default_scope :order =>"posts.created_at DESC" #display most current posts first 
end
