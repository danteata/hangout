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
end
