class AddInfoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :country, :string
    add_column :users, :language, :string
    add_column :users, :role, :string
    add_column :users, :rate, :float
    add_column :users, :specialty, :string
    add_column :users, :sub_specialty, :string
    add_column :users, :skills, :string
  end
end
