class AddPasswordDigestToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_digest, :string
    add_index :users, :password_digest, unique: true
  end
end
