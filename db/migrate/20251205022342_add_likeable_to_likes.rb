class AddLikeableToLikes < ActiveRecord::Migration[7.1]
  def change
    # add_reference :likes, :likeable, polymorphic: true, null: false
    add_column :likes, :likeable_id, :bigint unless column_exists?(:likes, :likeable_id)
    add_column :likes, :likeable_type, :string unless column_exists?(:likes, :likeable_type)

    return if index_exists?(:likes, %i[likeable_type likeable_id])

    add_index :likes, %i[likeable_type likeable_id], name: 'index_likes_on_likeable'
  end
end
