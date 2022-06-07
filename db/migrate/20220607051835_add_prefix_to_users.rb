class AddPrefixToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :prefix, :string
  end
end
