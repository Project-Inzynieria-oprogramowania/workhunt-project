class Organization < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'
    has_many :vacancies
    
    validates :name, presence: true
end