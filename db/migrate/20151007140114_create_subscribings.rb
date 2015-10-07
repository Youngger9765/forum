class CreateSubscribings < ActiveRecord::Migration
  def change
    create_table :subscribings do |t|
      t.integer :topic_id, :index => true
      t.integer :user_id, :index => true
      t.timestamps null: false
    end
    add_column :topics, :Subscribings_count, :integer, :default => 0
    add_column :users, :Subscribings_count, :integer, :default => 0
  end
end
