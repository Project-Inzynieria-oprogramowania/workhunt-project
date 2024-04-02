class User < ApplicationRecord
    has_secure_password
    
    validates :login, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :name, presence: true
    validates :surname, presence: true

    # правила обработки
    #   validates [имя поля], [проверки]
    # Проверки:
    #   presence: true          не является пустым (белые символы = пустой)
    #   length: {minimum: [значение], maximum: [значение]}
end