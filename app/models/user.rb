class User < ActiveRecord::Base
  belongs_to :provider

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ONLY_NUMBERS = /\A[0-9]+\z/
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :phone_number, format: { with: ONLY_NUMBERS, message:"should only have numeric values." }, allow_nil: true

  has_secure_password
  before_create :create_remember_token


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end

end
