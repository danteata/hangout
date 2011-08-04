module ProfilesHelper

  #return true if edit links should be hidden
  def hide_edit_links?
    not @hide_edit_links.nil?
  end
end
