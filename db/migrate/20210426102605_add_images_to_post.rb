class AddImagesToPost < ActiveRecord::Migration[5.2]
  def up
    add_column :posts, :images, :string, null: false
  end

  def down
    remove_column :posts, :images, :string, null: false
  end
end
