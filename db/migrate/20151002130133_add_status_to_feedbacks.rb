class AddStatusToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :status, :string, :defult => "draft"
  end
end
