class Organization < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'
    
    validates :name, presence: true

    before_save :downcase_login
    
    def downcase_login
        login.downcase!
    end
end