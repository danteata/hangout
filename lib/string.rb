class String
  #Return an alternative string if blank
  def or_else(alternative)
    blank? ? alternative :self
  end
end
