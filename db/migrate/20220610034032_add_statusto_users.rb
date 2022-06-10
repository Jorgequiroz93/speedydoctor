class AddStatustoUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :status, :string, default: "Off"
  end
end
