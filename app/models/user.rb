class User < ActiveRecord::Base
  # User may have one blog which dies with him
  has_one :blog, dependent: :destroy

  # Store emails downcased
  before_save :email_downcase


  # Validations

  # Name: present and between 3 - 30 chars
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }

  # Simple ruby email regex from emailregex.com
  REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  # Email: present, max 100 chars, regexed and unique
  validates :email, presence: true, length: { maximum: 100 },
    format: { with: REGEX }, uniqueness: { case_sensitive: false }

  # Activate secure password functionality
  has_secure_password

  # Password: min 8 chars, allow nil when editing profile information
  validates :password, length: { minimum: 8 }, allow_nil: true


  private

    def email_downcase
      self.email = self.email.downcase
    end
end
