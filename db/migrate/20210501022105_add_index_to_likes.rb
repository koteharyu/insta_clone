class AddIndexToLikes < ActiveRecord::Migration[5.2]
  def up
    add_index :likes, [:user_id, :post_id], unique: true
  end

  def down
    remove_index :likes, [:user_id, :post_id], unique: true
  end
end
