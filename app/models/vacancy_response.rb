class VacancyResponse < ApplicationRecord
  belongs_to :person
  belongs_to :vacancy

  enum status: { 
    sent: 'sent', 
    under_consideration: 'under consideration',
    reserved: 'in reserve', 
    interview_scheduled: 'interview scheduled', 
    internship_offered: 'internship offered', 
    accepted: 'accepted', 
    rejected: 'rejected' }

  validates :person_id, uniqueness: { scope: :vacancy_id, message: "has already responded to this vacancy" }
end