class User < ApplicationRecord
    validates :user_name, presence: true
    validates :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}

    has_many :cats,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Cat

    attr_reader :password

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)
        user && user.is_password?(password) ? user: nil
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def reset_session_token!
      self.session_token = SecureRandom::urlsafe_base64
      self.save! 
      self.session_token
    end

    def ensure_session_token
      self.session_token ||= SecureRandom::urlsafe_base64
    end
end
