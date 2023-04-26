class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :email, presence: true 
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8}
  before_validation :downcase_fields
  before_validation :remove_spacing

  def downcase_fields
    self.email.downcase!
  end

  def remove_spacing
    self.email.strip
  end

  def self.authenticate_with_credentials(email_address, pw)
    @user = User.find_by(email: email_address.downcase.strip)
    if @user && @user.authenticate(pw)
      return @user
    else
      return nil
    end
    
  end

end
