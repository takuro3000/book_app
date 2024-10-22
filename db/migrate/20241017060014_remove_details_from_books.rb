class RemoveDetailsFromBooks < ActiveRecord::Migration[7.1]
  def change
    remove_column :books, :difficulty, :integer
    remove_column :books, :post_count, :integer
  end
end
