class Message < ActiveRecord::Base
  attr_accessor :subject, :body

  validates :subject, :presence => true
  validates :body, :presence => true

  def initialize(params)
    @subject = params[:subject]
    @body = params[:body]
  end
end
