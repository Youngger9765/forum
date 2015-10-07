class AddPaperclipToFeedback < ActiveRecord::Migration
  def change
  	add_attachment :feedbacks, :logo
  end
end
