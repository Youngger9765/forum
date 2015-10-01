class Topic < ActiveRecord::Base
	validates_presence_of :name

	belongs_to :user 
	has_many :feedbacks
	belongs_to :category

end
