class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string :login, null: false, index: {unique: true}
      t.string :password_digest, null: false
      t.string :name, null: false
      t.text :about

      t.timestamps
    end
  end
end
