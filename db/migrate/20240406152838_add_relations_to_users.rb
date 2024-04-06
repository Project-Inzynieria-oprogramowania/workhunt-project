class Addrelationstousers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :account_type, polymorphic: true, default: 0, null: false
  end
end
