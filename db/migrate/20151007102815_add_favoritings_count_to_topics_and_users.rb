class AddFavoritingsCountToTopicsAndUsers < ActiveRecord::Migration
  def change
    add_column :topics, :favoritings_count, :integer, :default => 0
    add_column :users, :favoritings_count, :integer, :default => 0
  end
end
