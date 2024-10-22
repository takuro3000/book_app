class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :self_introduction, :text
    add_column :users, :x_url, :text
    add_column :users, :github_url, :text
  end
end
