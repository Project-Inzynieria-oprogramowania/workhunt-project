class Person < ApplicationRecord
    belongs_to :user

    validates :name, presence: true
    validates :surname, presence: true
    validates :sex, length: { is: 1 }, format: {with: /\Amale|female\z/, multiline: true}
    before_save :downcase_login
    
    def downcase_login
        login.downcase!
    end
end