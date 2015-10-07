class CreateLikings < ActiveRecord::Migration
  def change
    create_table :likings do |t|

      t.integer :topic_id, :index => true
      t.integer :user_id, :index => true
      t.timestamps null: false
    end

    add_column :topics, :likings_count, :integer, :default => 0
    add_column :users, :likings_count, :integer, :default => 0
  
  end
end
