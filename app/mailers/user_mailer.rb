class UserMailer < ActionMailer::Base
  default :from => "notifications@hangout.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/login"
    mail(:to => user.email,
         :subject=>"Welcome to the MEST hangout.")
  end

  def reminder(user)
    @user = user
    mail(:to =>user.email,
         :subject=>"Your password reminder.")
  end

  def friend_request(user, friend)
    @user = user
    @pending_friend = friend
    @accept_url = url_for(:controller => "friendships", :action =>"accept",  :id=>@user.id, :host =>"localhost:3000")
    @decline_url = url_for(:controller =>"friendships",:action => "decline", :id => @user.id, :host =>"localhost:3000")
    mail(:to=>user.email,
        :subject=>"Request for your friendship")
  end

  #method to render the corresponding message
  #params user, the sender, recipient, the receiver
  #message, the message object which component will be rendered in view
  def message(user, recipient, message)
    @recipient = recipient
    @user = user
    @message = message
    mail(:to =>recipient, :subject => message.subject)
  end
end
