class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :difficulty
      t.text :description
      t.integer :volume
      t.date :published_day
      t.string :language
      t.string :company
      t.text :link
      t.integer :post_count

      t.timestamps
    end
  end
end
