class Faq < ActiveRecord::Base
  belongs_to :user

  QUESTIONS = %w(bio skillsets schools companies
                music movies television books)
  FAVOURITES = QUESTIONS - %w(bio) #contains all elements in questions array except bio 

  def initialize
    super
    QUESTIONS.each do |question|
      self[question] = " "
    end
  end
end

# == Schema Information
#
# Table name: faqs
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  bio        :text
#  skillsets  :text
#  schools    :text
#  companies  :text
#  music      :text
#  movies     :text
#  television :text
#  books      :text
#  created_at :datetime
#  updated_at :datetime
#

