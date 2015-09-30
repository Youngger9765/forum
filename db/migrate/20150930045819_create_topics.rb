class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.text :content
      t.boolean :is_public
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
