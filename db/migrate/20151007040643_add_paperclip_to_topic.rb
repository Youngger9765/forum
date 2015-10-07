class AddPaperclipToTopic < ActiveRecord::Migration
  def change
  	add_attachment :topics, :logo
  end
end
