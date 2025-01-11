class RemoveTitleAndTagFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :title, :string
    remove_column :posts, :tag, :string
  end
end
