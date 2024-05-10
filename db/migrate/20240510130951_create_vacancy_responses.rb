class CreateVacancyResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :vacancy_responses do |t|
      t.belongs_to :person, null: false, foreign_key: true
      t.belongs_to :vacancy, null: false, foreign_key: true
      t.string :status, null: false
      t.text :comments

      t.timestamps
    end
    add_check_constraint :vacancy_responses, "status IN ('sent', 'under consideration', 'in reserve', 'interview scheduled', 'internship offered', 'accepted', 'rejected')"
    add_index :vacancy_responses, [:person_id, :vacancy_id], unique: true
  end
end
