class Organization < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'
    has_many :vacancies, foreign_key: 'organization_id'
    
    validates :name, presence: true

    before_validation :set_defaults, if: :new_record?

    private

    def set_defaults
        self.name = "User##{self.user_id.hash.abs}"
    end
end