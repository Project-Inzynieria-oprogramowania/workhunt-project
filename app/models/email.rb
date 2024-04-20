class Email < ApplicationRecord
    belongs_to :user

    validates :address, presence: true
    validates :address, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }, if: -> { address.present? }
end
