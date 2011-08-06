require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :microposts, :dependent => :destroy

  has_one :spec, :dependent => :destroy

  has_one :faq, :dependent => :destroy

  has_many :friendships

  has_many :friends,
           :through => :friendships,
           :conditions => "status = 'accepted'",
           :order => :name
  has_many :requested_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "status = 'requested'",
           :order => :initiated_at
  has_many :pending_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "status = 'pending'",
           :order => :initiated_at
  
  email_regex = /\A[\w+\-.]+@[a-z\-.\d]+\.[a-z]+\z/i
  
  validates :name, :presence=> true,
                   :length=>{:maximum=>30}
  
  validates :email, :presence=> true,
                    :format => {:with=> email_regex},
                    :uniqueness => {:case_sensitive => false}
  validates :password, :presence=>true,
                       :length=>{:within => 6..40},
                       :confirmation =>true

  before_save :encrypt_password  #callback function to save the encrypted password  
  

  def self.authenticate(email, submitted_password) #fetches user with the email given and compares emails corresponding encrypted_password with encrypted version of submitted password 
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def has_password? (submitted_password) #compares an encrypted version of submitted password with encrypted_password in database. 
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.is_same?(user, friend)
    user == friend
  end


  private

  def encrypt_password #encrypt the virtual attribute password and assign to encrypted_password 
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string) #encrypt the password parameter given using the user's salt 
    secure_hash("#{salt}--#{string}")
  end

  def make_salt #create a salt attribute for user identification using current time and virtual password attribute 
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string) #function to perform the encryption process. 
    Digest::SHA2.hexdigest(string)
  end
end


# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#

