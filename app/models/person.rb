class Person < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'
    has_one :cv, dependent: :destroy

    enum sex: { unspecified: 'unspecified', male: 'male', female: 'female', other: 'other' }
    validates :name, presence: true
    validates :surname, presence: true
    validate :DOB_validate, if: -> { self.DOB.present? }

    before_validation :set_defaults, if: :new_record?
    
    private

    def set_defaults
        self.sex ||= 'unspecified'
        self.name ||= "User_name##{self.user_id.hash.abs}"
        self.surname ||= "User_surname##{self.user_id.hash.abs}"
    end

    def DOB_validate 
        return if self.DOB < DateTime.now
        errors.add :DOB, 'must be in the past'
    end
end