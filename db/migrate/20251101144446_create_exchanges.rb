class CreateExchanges < ActiveRecord::Migration[7.1]
  def change
    create_table :exchanges do |t|
      t.text :message, null: false
      t.references :user, null: false, foreign_key: true
      t.references :item,     null: false, foreign_key: true
      t.references :order,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
