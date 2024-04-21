class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :address, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :links, [:address, :user_id], unique: true
  end
end
