require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :microposts, :dependent => :destroy

  has_one :spec, :dependent => :destroy
  
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

