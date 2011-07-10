module ApplicationHelper

  def title
    base_title = "My Site"
    unless @title.nil?
      "#{base_title} | #{@title}"
    else
      base_title
    end

  end
end
