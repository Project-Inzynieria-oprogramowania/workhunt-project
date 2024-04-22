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
        return if start_date.to_i < DateTime.now.to_i
        errors.add :start_date, 'must be older than the current time'
    end
    
    def end_date_validate
        return if end_date.to_i < DateTime.now.to_i
        errors.add :end_date, 'must be older than the current time'
    end

    def dates_compare
        return if end_date.to_i > start_date.to_i
        errors.add :end_date, 'must be older than the start date'
    end
end