require_relative '../../app/assets/config/initializers/work_constants.rb'

class Vacancy < ApplicationRecord
    belongs_to :organization
    
    validates :title, presence: true
    validates :job_type, presence: true, one_of: JOB_TYPES.values.flatten, message: "is not valid"
    validates :education, presence: true, one_of: EDUCATION, message: "is not valid"
    validates :subordination_level, presence: true, one_of: SUBORDINATION_LEVEL, message: "is not valid"
    validates :contract_type, presence: true, one_of: CONTRACT_TYPE, message: "is not valid"
    validates :working_time, presence: true, one_of: WORKING_TIME, message: "is not valid"
    validates :status, presence: true, one_of: STATUS, message: "is not valid"
    # monetize :salary_cents
end