class CreateReplies < ActiveRecord::Migration[7.1]
  def change
    create_table :replies do |t|
        t.text :context, null: false
        t.references :user, null: false, foreign_key: true
        t.references :item, null: false, foreign_key: true
        t.references :comment, null: false, foreign_key: true
      t.timestamps
    end
  end
end
