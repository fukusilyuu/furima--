class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.integer :user, null: false
      t.integer :item, null: false
      t.timestamps
    end
  end
end
