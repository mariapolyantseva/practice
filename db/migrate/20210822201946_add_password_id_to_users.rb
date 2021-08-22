class AddPasswordIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_id, :integer
    remove_column :users, :password3_id
  end
end
