require_relative '../../app/assets/config/initializers/work_constants.rb'

class Vacancy < ApplicationRecord
    belongs_to :organization, foreign_key: 'organization_id'
    
    attr_accessor :job_category
    validates :title, presence: true
    validates :job_type, presence: true, inclusion: { in: JOB_TYPES.values.flatten, message: "is not valid" }
    validates :working_time, presence: true, inclusion: { in: WORKING_TIME, message: "is not valid" }
    validates :work_type, presence: true, inclusion: { in: WORK_TYPE, message: "is not valid" }
    validates :education, presence: true, inclusion: { in: EDUCATION, message: "is not valid" }
    validates :subordination_level, presence: true, inclusion: { in: SUBORDINATION_LEVEL, message: "is not valid" }
    validates :contract_type, presence: true, inclusion: { in: CONTRACT_TYPE, message: "is not valid" }
    validates :status, presence: true, inclusion: { in: STATUS, message: "is not valid" }
    monetize :salary_min_cents, numericality: true, allow_nil: true
    monetize :salary_max_cents, numericality: true, allow_nil: true
    validate :salary_range

    # validates :job_type, presence: true, one_of: JOB_TYPES.values.flatten, message: "is not valid"
    # validates :education, presence: true, one_of: EDUCATION, message: "is not valid"
    # validates :subordination_level, presence: true, one_of: SUBORDINATION_LEVEL, message: "is not valid"
    # validates :contract_type, presence: true, one_of: CONTRACT_TYPE, message: "is not valid"
    # validates :working_time, presence: true, one_of: WORKING_TIME, message: "is not valid"
    # validates :status, presence: true, one_of: STATUS, message: "is not valid"

    before_validation :salary_convertation
    
    private

    def self.ransackable_attributes(auth_object = nil)
        ["title", "description",
        "job_type", "work_type", "education", "subordination_level", "contract_type", "working_time", "currency"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["user"]
    end

    def salary_convertation
        self.salary_min_cents = self.salary_min.nil? ? nil : self.salary_min * 100
        self.salary_max_cents = self.salary_max.nil? ? nil : self.salary_max * 100
    end

    def salary_range
        return if salary_min.nil? || salary_max.nil? || salary_min < salary_max
        errors.add(:salary_max, "must be more than salary min")
    end
end