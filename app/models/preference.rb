class Preference < ActiveRecord::Base
  belongs_to :user

  validates :profile_view, :presence => true
end
