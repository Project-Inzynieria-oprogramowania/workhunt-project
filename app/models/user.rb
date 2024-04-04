class User < ApplicationRecord
    PASSWORD_FORMAT = /\A
        (?=.{8,})          # Must contain 8 or more characters
        (?=.*\d)           # Must contain a digit
        (?=.*[a-z])        # Must contain a lower case character
        (?=.*[A-Z])        # Must contain an upper case character
        (?=.*[[:^alnum:]]) # Must contain a symbol
    /x

    has_secure_password

    validates :login, presence: true, uniqueness: true
    validates :password, format: { with: PASSWORD_FORMAT }
    validates :password_digest, presence: true
    validates :name, presence: true
    validates :surname, presence: true

    before_save :downcase_login
    
    def downcase_login
        login.downcase!
    end
    # правила обработки
    #   validates [имя поля], [проверки]
    # Проверки:
    #   presence: true          не является пустым (белые символы = пустой)
    #   length: {minimum: [значение], maximum: [значение]}
end