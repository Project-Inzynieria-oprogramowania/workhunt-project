class Experience < ApplicationRecord
    belongs_to :cv

    validates :start_date, presence: true
    validate :start_date_validate, if: -> { start_date.present? }
    validate :end_date_validate, if: -> { end_date.present? }
    validate :dates_compare, if: -> { start_date.present? && end_date.present? }
    validates :position, presence: true
    validates :outline, presence: true

    ransacker :experience_time do
        Arel.sql(
            "((CAST(strftime('%Y', COALESCE(end_date, CURRENT_DATE)) AS INTEGER) - \
                CAST(strftime('%Y', start_date) AS INTEGER)) * 12) + \
            (CAST(strftime('%m', COALESCE(end_date, CURRENT_DATE)) AS INTEGER) - \
                CAST(strftime('%m', start_date) AS INTEGER))")
    end
    
    private 

    def self.ransackable_attributes(auth_object = nil)
        ["experience_time"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["cv"]
    end

    def start_date_validate
        return if start_date < DateTime.now
        errors.add :start_date, 'must be in the past'
    end
    
    def end_date_validate
        return if end_date < DateTime.now
        errors.add :end_date, 'must be in the past'
    end

    def dates_compare
        return if end_date > start_date
        errors.add :end_date, 'must be after the start date'
    end
end