class RemoveEmailFromUsers < ActiveRecord::Migration[7.1]
  def change
    # 既に unique index が存在するはずなので、まずは index を削除
    remove_index :users, :email

    # その後、カラムを削除
    remove_column :users, :email, :string
  end
end
