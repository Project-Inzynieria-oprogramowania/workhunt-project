class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :sex
      t.date :DOB
      t.text :about

      t.timestamps
    end
  end
end
