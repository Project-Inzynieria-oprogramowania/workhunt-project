require_relative '../../app/assets/config/initializers/work_constants.rb'

class Education < ApplicationRecord
    belongs_to :cv

    validates :start_date, presence: true
    validate :start_date_validate, if: -> { start_date.present? }
    validate :end_date_validate, if: -> { end_date.present? }
    validate :dates_compare, if: -> { start_date.present? && end_date.present? }
    validates :institution, presence: true
    validates :direction, presence: true
    validates :specialization, presence: true
    validates :education_level, presence: true, inclusion: { in: EDUCATION, message: "is not valid" }

    private 

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