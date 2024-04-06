class AddRelationsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :account_type, :integer, default: 0, null: false
    add_reference :people, :user, foreign_key: true
    add_reference :organizations, :user, foreign_key: true
  end
end
