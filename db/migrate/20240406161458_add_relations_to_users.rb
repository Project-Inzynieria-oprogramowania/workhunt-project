class AddRelationsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :account_type, :integer, default: 0, null: false
    add_reference :users, :account_type, default: 0, null: false
  end
end
