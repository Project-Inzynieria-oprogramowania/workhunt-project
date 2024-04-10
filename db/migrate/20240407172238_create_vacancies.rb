class CreateVacancies < ActiveRecord::Migration[7.1]
  def change
    create_table :vacancies do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :salary_min, precision: 10, scale: 0
      t.decimal :salary_max, precision: 10, scale: 0
      t.string :country
      t.string :city
      t.text :skills_mandatory
      t.text :skills_optional
      t.integer :experience

      t.string :job_type, null: false
      t.string :education, null: false
      t.string :subordination_level, null: false
      t.string :contract_type, null: false
      t.string :working_time, null: false
      t.string :status, null: false
      # t.check_constraint "job_type IN (#{JOB_TYPES.values.flatten.map { |type| "'#{type}'" }.join(', ')})"
      # t.check_constraint "education IN (#{EDUCATION.map { |edu| "'#{edu}'" }.join(', ')})"
      # t.check_constraint "subordination_level IN (#{SUBORDINATION_LEVEL.map { |level| "'#{level}'" }.join(', ')})"
      # t.check_constraint "contract_type IN (#{CONTRACT_TYPE.map { |type| "'#{type}'" }.join(', ')})"
      # t.check_constraint "working_time IN (#{WORKING_TIME.map { |time| "'#{time}'" }.join(', ')})"
      # t.check_constraint "status IN (#{STATUS.map { |stat| "'#{stat}'" }.join(', ')})"

      t.timestamps
    end
    add_reference :vacancies, :organization, null: false, foreign_key: true
  end
end
