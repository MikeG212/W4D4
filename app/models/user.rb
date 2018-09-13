class User
  # Validations
  validates :email, :password_digest, :session_token, presence: true, uniqueness: true,
  valdiates :password, length: { minimum: 6, allow_nil: true }

  after_initialize: ensure_session_token

  #Associations


  #Methods

  attr_reader :password

  def password=(pw)
    @password = pw
    self.password.digest = BCrypt::Password.create(pw)
  end

  def self.find_by_credentials(email), password)
    user = User.find_by(email: email)
    user && user.is_password?(password) ? user: nil
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)

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
    @session_token ||= SecureRandom.urlsafe_base64
  end
end
