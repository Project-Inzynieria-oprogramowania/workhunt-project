class ChangeLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :title, :string
  end
end
