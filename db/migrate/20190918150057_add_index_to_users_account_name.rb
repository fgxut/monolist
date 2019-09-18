class AddIndexToUsersAccountName < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :account_name, unique: true
  end
end
