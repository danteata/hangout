class Spec < ActiveRecord::Base
  attr_accessible  :first_name, :last_name, :occupation, :city, :birthday
  belongs_to :user

  validates :first_name, :presence => true
  #validates :gender, :inclusion => :in =>["Male", "Female"]
  #validates :birthday, :inclusion=>  :in=>1930..DateTime.now
  ALL_FIELDS = %w(first_name last_name occupation gender birthday city)
  #return the full name
  def full_name
    [first_name, last_name].join(" ")
  end
end

# == Schema Information
#
# Table name: specs
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  first_name :string(255)
#  last_name  :string(255)
#  gender     :string(255)
#  birthday   :date
#  occupation :string(255)
#  city       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

