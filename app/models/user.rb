 class User < ApplicationRecord
  # Validations
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true

  after_initialize :ensure_session_token

  #Associations


  #Methods

  attr_reader :password

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user: nil
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(
  end

  def self.generate_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end
