class Cv < ApplicationRecord
    belongs_to :person
    has_many :educations, dependent: :destroy
    accepts_nested_attributes_for :educations

    validates :about, presence: true
    validates :about, length: {minimum: 5}, if: -> { about.present? }
end