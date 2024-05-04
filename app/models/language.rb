class Language < ApplicationRecord
    belongs_to :cv

    validates :name, presence: true
    validates :level, presence: true
end