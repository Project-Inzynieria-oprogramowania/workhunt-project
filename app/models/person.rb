class Person < ApplicationRecord
    belongs_to :user, foreign_key: 'user_id'

    enum sex: { unspecified: 'unspecified', male: 'male', female: 'female', other: 'other' }
    validates :name, presence: true
    validates :surname, presence: true
end