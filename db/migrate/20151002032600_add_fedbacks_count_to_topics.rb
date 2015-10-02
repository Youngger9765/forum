class AddFedbacksCountToTopics < ActiveRecord::Migration
  def change
  	add_column :topics, :feedbacks_count, :integer, :default => 0
  end
end
