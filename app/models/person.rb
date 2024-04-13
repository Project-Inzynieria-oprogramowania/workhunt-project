class Person < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'

    enum sex: { unspecified: 'unspecified', male: 'male', female: 'female', other: 'other' }
    validates :name, presence: true
    validates :surname, presence: true

    after_initialize :set_defaults, if: :new_record?
    
    private

    def set_defaults
        self.sex ||= 'unspecified'
        self.name ||= "User_name##{self.user_id.hash}"
        self.surname ||= "User_surname##{self.user_id.hash}"
    end
end