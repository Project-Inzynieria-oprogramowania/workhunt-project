class Cv < ApplicationRecord
    belongs_to :person

    validates :about, presence: true
    validates :about, length: {minimum: 5}, if: -> { about.present? }
end