class RemoveEmailFromAdmins < ActiveRecord::Migration[7.1]
  def change
    def change
      # 既に unique index が存在するはずなので、まずは index を削除
      remove_index :admins, :email
  
      # その後、カラムを削除
      remove_column :admins, :email, :string
    end
  end
end