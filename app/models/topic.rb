class Topic < ActiveRecord::Base
	validates_presence_of :name

	belongs_to :user 
	has_many :feedbacks
	belongs_to :category

	delegate :name, :to => :category, :prefix => true, :allow_nil => true
	delegate :email, :to => :user, :prefix => true, :allow_nil => true

end
