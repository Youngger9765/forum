class AddLatestFeedbackToTopics < ActiveRecord::Migration
  def change
  	add_column :topics, :latest_feedback_time, :datetime
  end
end
