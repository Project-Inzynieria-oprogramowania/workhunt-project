class CreateCvs < ActiveRecord::Migration[7.1]
    def change
        create_table :cvs do |t|
            t.references :person, null: false, foreign_key: true
            t.text :about, null: false
            t.text :skills
            t.string :country
            t.string :city
            t.text :interests
    
            t.timestamps
        end
    end
end
  
class CreateEducations < ActiveRecord::Migration[7.1]
    def change
        create_table :educations do |t|
            t.references :cv, null: false, foreign_key: true
            t.date :start_date
            t.date :end_date
            t.string :institution
            t.string :direction
            t.string :specialization
            t.string :education_level 
    
            t.timestamps
        end
    end
end
  
class Cv < ApplicationRecord
    has_many :educations, dependent: :destroy
    belongs_to :person
end

class Education < ApplicationRecord
    belongs_to :cv
end