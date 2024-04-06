class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :sex, null: false
      t.date :DOB
      t.text :about

      t.timestamps
    end
    add_check_constraint :people, "sex IN ('male', 'female', 'other')"
  end
end
