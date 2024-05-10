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
end