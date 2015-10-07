class Topic < ActiveRecord::Base
	validates_presence_of :name

	belongs_to :user 
	has_many :feedbacks
	belongs_to :category

	has_many :taggings
	has_many :tags, :through => :taggings

	delegate :name, :to => :category, :prefix => true, :allow_nil => true
	delegate :email, :to => :user, :prefix => true, :allow_nil => true

	def tag_list
   		self.tags.map{ |t| t.name }.join(",")
  	end

	def tag_list=(str)
	   	arr = str.split(",")

		self.tags = arr.map do |t|
	    tag = Tag.find_by_name(t)
	    unless tag
	  	  tag = Tag.create!( :name => t )
	    end
	      tag
	    end

	end

	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/      


end
