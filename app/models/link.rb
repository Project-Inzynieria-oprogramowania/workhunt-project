class Link < ApplicationRecord
    belongs_to :user

    validates :address, presence: true
    validates :address, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'is not a valid URL' }, if: -> { address.present? }
    validates :address, uniqueness: { scope: :user_id, message: "has already been taken for this user" }
end