class Person < ApplicationRecord
    has_one :account, as: :account_type, class_name: 'User'

    validates :name, presence: true
    validates :surname, presence: true
    validates :sex, length: { is: 1 }, format: {with: /\Amale|female|other\z/, multiline: true}
    before_save :downcase_login
    
    def downcase_login
        login.downcase!
    end
end