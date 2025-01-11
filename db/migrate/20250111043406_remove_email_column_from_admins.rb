class RemoveEmailColumnFromAdmins < ActiveRecord::Migration[7.1]
  def change
    if column_exists?(:admins, :email)
      if index_exists?(:admins, :email, name: 'index_admins_on_email')
        remove_index :admins, name: 'index_admins_on_email'
      end
      remove_column :admins, :email, :string
    end
  end
end
