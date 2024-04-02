class Organization < ApplicationRecord
    has_secure_password
    
    validates :login, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :name, presence: true
end