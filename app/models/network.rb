class Network < ActiveRecord::Base
  attr_accessible :facebook, :linkedin, :twitter, :youtube
  belongs_to :user

  NETWORKS = %w(facebook linkedin twitter youtube)
end

# == Schema Information
#
# Table name: networks
#
#  id         :integer         not null, primary key
#  facebook   :string(255)
#  twitter    :string(255)
#  linkedin   :string(255)
#  youtube    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

