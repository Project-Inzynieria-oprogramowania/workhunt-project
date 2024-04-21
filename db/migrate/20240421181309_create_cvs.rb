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
