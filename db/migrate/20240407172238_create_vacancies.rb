class CreateVacancies < ActiveRecord::Migration[7.1]
  def change
    create_table :vacancies do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :salary_min, precision: 10, scale: 0
      t.decimal :salary_max, precision: 10, scale: 0
      t.string :country
      t.string :city
      t.text :skills
      t.integer :experience
      # employment_type -> две другие таблицы
      # education -> другая таблица?
      # subordination_level -> другая таблица?
      # contract -> другая таблица?
      # working_time -> другая таблица? 
      t.string :status, null: false

      t.timestamps
    end
    add_check_constraint :vacancies, "status IN ('opened', 'closed', 'active', 'pending', 'withdrawn')"
  end
end
