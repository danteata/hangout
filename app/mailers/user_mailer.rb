class UserMailer < ActionMailer::Base
  default :from => "notifications@hangout.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/login"
    mail(:to => user.email,
         :subject=>"Welcome to the MEST hangout.")
  end

  def reminder(user)
    #generates a new password and hashes it into database while making it available in mail as @password
    @user = user
    @password = @user.password = generated_password 
    @user.save!

    mail(:to =>user.email,
         :subject=>"Your password reminder.")
  end

  def friend_request(user, friend)

    @user = user
    @friend = friend
    @accept_url = url_for(:controller => "friendships", :action =>"accept",  :id=>@user.id, :host =>"localhost:3000")
    @decline_url = url_for(:controller =>"friendships",:action => "decline", :id => @user.id, :host =>"localhost:3000")

    mail(:to=>@friend.email,
        :subject=>"Request for your friendship")

  end

  #method to render the corresponding message
  #params user, the sender, recipient, the receiver
  #message, the message object which component will be rendered in view
  def correspond_mail(user, recipient, message)
    @recipient = recipient
    @sender = user
    @message = message
    mail(:to =>recipient.email, :subject => message.subject)
    #mail(:to =>"dantheta@yahoo.co.uk", :subject => "just testing it out")
  end

  private 

    def generated_password(size= 8)
      chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o O l 1 0) #removed characters that can confuse the user 
      (1..size).collect{|a| chars[rand(chars.size)]}.join
    end
end
