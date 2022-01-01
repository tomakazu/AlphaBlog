class User < ApplicationRecord
    has_many :articles
    has_secure_password
    
    before_save { self.email = email.downcase }
    validates :username, presence: true,
                         uniqueness: { case_sensitive: false},
                         length: { minimum: 3 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                      uniqueness: true, length: {in: 6..25 },
                      format: {with: VALID_EMAIL_REGEX}
end