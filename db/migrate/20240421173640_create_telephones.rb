class CreateTelephones < ActiveRecord::Migration[7.1]
  def change
    create_table :telephones do |t|
      t.string :number, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :telephones, [:user_id, :number], unique: true
  end
end
