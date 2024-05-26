class CreateAvatars < ActiveRecord::Migration[7.1]
  def change
    create_table :avatars do |t|
      t.string :image
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
