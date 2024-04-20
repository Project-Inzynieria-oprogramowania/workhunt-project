class Email < ApplicationRecord
    belongs_to :user

    validates :address, presence: true
    validates :address, :with => /@/, if: -> { address.present? }
end
