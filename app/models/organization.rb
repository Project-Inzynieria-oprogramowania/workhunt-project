class Organization < ApplicationRecord
    has_one :account, as: :account_type, class_name: 'User'
    
    validates :name, presence: true

    before_save :downcase_login
    
    def downcase_login
        login.downcase!
    end
end