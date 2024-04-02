class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :login, null: false, index: {unique: true} # index: {unique: true}   уникальность
      t.string :password_digest, null: false              # null: false             не пустое поле
      t.string :name, null: false
      t.string :surname, null: false
      t.text :about

      t.timestamps
    end
  end
end
