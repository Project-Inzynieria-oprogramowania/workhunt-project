class VacancyResponse < ApplicationRecord
  belongs_to :person
  belongs_to :vacancy

  # 'sent, 'under consideration', 'in reserve', 'interview scheduled', 'internship offered', 'accepted', 'rejected'
end