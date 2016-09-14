class AdminsToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :admin_status
    add_column :users, :admin, :boolean
  end
end
