class Telephone < ApplicationRecord
    belongs_to :user

    validates :number, presence: true
    validate :phone_number_complexity, if: -> { number.present? }
    validates :number, uniqueness: { scope: :user_id, message: "has already been taken for this user" }

    before_validation :normalize_phone_number

    private

    def phone_number_complexity
        return if Phonelib.parse(self.number).valid?
        errors.add(:number, "is not a valid phone number")
    end

    def normalize_phone_number
        self.number = Phonelib.parse(self.number).e164
    end
end