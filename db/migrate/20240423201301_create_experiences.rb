class CreateExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :experiences do |t|
      t.references :cv, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date
      t.string :position, null: false
      t.string :country
      t.string :city
      t.string :company
      t.text :outline, null: false
      t.text :responsibilities
      t.text :achievements

      t.timestamps
    end
  end
end
