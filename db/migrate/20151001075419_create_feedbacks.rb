class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|

      t.string :name

      t.integer :topic_id

      t.timestamps null: false
    end

    add_index :feedbacks, :topic_id
  end
end
