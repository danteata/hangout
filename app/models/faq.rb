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
