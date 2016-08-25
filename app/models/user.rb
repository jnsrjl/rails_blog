class User < ActiveRecord::Base
  # Simple ruby email regex from emailregex.com
  REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  # Validations
  # Name: present and between 3 - 30 chars
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }

  # Email: present, max 100 chars, regexed and unique
  validates :email, presence: true, length: { maximum: 100 },
    format: { with: REGEX }, uniqueness: { case_sensitive: false }

  # Activate secure password functionality
  has_secure_password

  # Password: min 8 chars
  validates :password, length: { minimum: 8 }
end
