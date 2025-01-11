class AddCustomIdToAdmins < ActiveRecord::Migration[7.1]
  def change
    add_column :admins, :custom_id, :string
  end
end
