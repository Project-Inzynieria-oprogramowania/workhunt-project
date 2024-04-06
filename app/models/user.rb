class User < ApplicationRecord
    # enum account_type: { person: 0, organization: 1 }
    belongs_to :account_type, polymorphic: true
    #has_one (:person || :organization)
    
    has_secure_password

    PASSWORD_FORMAT = /\A
        (?=.*\d)           # Must contain a digit
        (?=.*[a-z])        # Must contain a lower case character
        (?=.*[A-Z])        # Must contain an upper case character
        (?=.*[[:^alnum:]]) # Must contain a symbol
    /x

    validates :login, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 8, maximum: 32}#, format: { with: PASSWORD_FORMAT }

    before_save :downcase_login
    
    def downcase_login
        login.downcase!
    end
end