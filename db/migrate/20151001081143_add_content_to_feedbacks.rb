class AddContentToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :content, :text
  end
end
