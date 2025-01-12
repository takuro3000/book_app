class AddUniqueIndexToPosts < ActiveRecord::Migration[7.1]
  def change
    add_index :posts, [:user_id, :book_id], unique: true
  end
end
