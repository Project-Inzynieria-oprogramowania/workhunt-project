class CreateEducations < ActiveRecord::Migration[7.1]
  def change
    create_table :educations do |t|
      t.references :cv, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date
      t.string :institution, null: false
      t.string :direction, null: false
      t.string :specialization, null: false
      t.string :education_level, null: false

      t.timestamps
    end
  end
end
