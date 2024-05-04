class CreateLanguages < ActiveRecord::Migration[7.1]
  def change
    create_table :languages do |t|
      t.references :cv, null: false, foreign_key: true
      t.string :name, null: false
      t.string :level, null: false
      t.string :certificates
      
      t.timestamps
    end
  end
end
