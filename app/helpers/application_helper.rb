module ApplicationHelper
  require 'string' #making the 'or_else' function accessible in views 
  
  def title
    base_title = "My Site"
    unless @title.nil?
      "#{base_title} | #{@title}"
    else
      base_title
    end

  end

  #returns the facebook profile name or nothing
  def facebook_network_profile(user)
    (user.network.facebook.nil?) ? "" : user.network.facebook
  end

  #returns the facebook profile name or nothing
  def linkedin_network_profile(user)
    (user.network.linkedin.nil?) ? "" : user.network.linkedin
  end
  
  #returns the facebook profile name or nothing
  def twitter_network_profile(user)
    (user.network.twitter.nil?) ? "" : user.network.twitter
  end

  #returns the facebook profile name or nothing
  def youtube_network_profile(user)
    (user.network.youtube.nil?) ? "" : user.network.youtube
  end
end
