class CreateRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :relationships do |t|
      t.references :following
      t.references :follower
      t.timestamps
    end
  end
end
