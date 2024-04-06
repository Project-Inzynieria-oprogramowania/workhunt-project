class Person < ApplicationRecord
    has_one :account, as: :account_type, class_name: 'User'

    enum sex: { unspecified: 'unspecified', male: 'male', female: 'female', other: 'other' }
    validates :name, presence: true
    validates :surname, presence: true
    before_save :downcase_login
    
    def downcase_login
        login.downcase!
    end
end