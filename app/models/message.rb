class Message 
  include ActiveModel::Validations
  include ActiveModel::Conversion
  attr_accessor :subject, :body

  validates :subject, :presence => true
  validates :body, :presence => true

  def initialize(params)
    @subject = params[:subject]
    @body = params[:body]
  end

  def persisted?
    false
  end

  def protect_against_forgery?
    false
  end
  #def self.validate
    #return flash[:notice] = "Subject or message can't be blank" if @subject == " " or @message == " "
    #@subject != nil or ""
  #end
end
