class AddIdstoPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :user, foreign_key: true
    add_reference :posts, :book, foreign_key: true
  end
end
