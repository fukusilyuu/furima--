class AddLikeableToLikes < ActiveRecord::Migration[7.1]
  def change
    #add_reference :likes, :likeable, polymorphic: true, null: false
    add_column :likes, :likeable_id, :integer
    add_column :likes, :likeable_type, :string

    add_index :likes, [:likeable_type, :likeable_id]
  end
end
