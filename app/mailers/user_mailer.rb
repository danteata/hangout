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

  def friend_request(user, pending_friend)
    @user = user
    @pending_friend = pending_friend
    mail(:to=>user.email,
        :subject=>"Request for your friendship")
  end
end
