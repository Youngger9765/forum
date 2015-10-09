class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, :default => "unregister"
  end
end
