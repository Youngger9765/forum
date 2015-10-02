class Feedback < ActiveRecord::Base

	validates_presence_of :content

	belongs_to :topic,  :counter_cache => true # topics#feedbacks_count
	belongs_to :user

end


# add_column :topcis, :feedbacks_count, :integer, :default => 0 
