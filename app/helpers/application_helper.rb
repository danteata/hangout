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
  def facebook_profile
    @network = current_user.network ||= Network.new
    (@network.facebook.nil?) ? "" : @network.facebook
  end

  #returns true if current_user has a facebook profile
  def facebook_profile?
    @network = current_user.network ||= Network.new
    !(@network.facebook.nil? || @network.facebook.blank?)
  end

  #returns the facebook profile name or nothing
  def twitter_profile
    @network = current_user.network ||= Network.new
    (@network.twitter.nil?) ? "" : @network.twitter
  end

  #returns true if current_user has a facebook profile
  def twitter_profile?
    @network = current_user.network ||= Network.new
    !(@network.twitter.nil? || @network.twitter.blank?)
  end

  #returns the facebook profile name or nothing
  def linkedin_profile
    @network = current_user.network ||= Network.new
    (@network.linkedin.nil? || @network.linkedin.blank?) ? "" : @network.linkedin
  end

  #returns true if current_user has a facebook profile
  def linkedin_profile?
    @network = current_user.network ||= Network.new
    !(@network.linkedin.nil? || @network.linkedin.blank?)
  end

  #returns the facebook profile name or nothing
  def youtube_profile
    @network = current_user.network ||= Network.new
    (@network.youtube.nil?) ? "" : @network.youtube
  end

  #returns true if current_user has a facebook profile
  def youtube_profile?
    @network = current_user.network ||= Network.new
    !(@network.youtube.nil? || @network.youtube.blank?)
  end
  #returns the facebook profile name or nothing
  def youtube_network_profile(user)
    (user.network.youtube.nil?) ? "" : user.network.youtube
  end
  
  #returns the facebook profile name or nothing
  def youtube_network_profile(user)
    (user.network.youtube.nil?) ? "" : user.network.youtube
  end

  #returns the facebook profile name or nothing
  def youtube_network_profile(user)
    (user.network.youtube.nil?) ? "" : user.network.youtube
  end


end
