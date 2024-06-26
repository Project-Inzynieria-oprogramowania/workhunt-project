class CreateEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails do |t|
      t.string :address, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :emails, [:address, :user_id], unique: true
  end
end
