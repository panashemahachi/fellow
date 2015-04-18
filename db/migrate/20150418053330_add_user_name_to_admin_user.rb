class AddUserNameToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :admin_user, :string
  end
end
