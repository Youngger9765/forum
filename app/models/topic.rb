class Topic < ActiveRecord::Base
	validates_presence_of :name

	belongs_to :user 
	has_many :feedbacks
	belongs_to :category

	has_many :taggings
	has_many :tags, :through => :taggings

  has_many :favoritings
  has_many :favorite_users, :through => :favoritings , :source => :user

  has_many :likings
  has_many :like_users, :through => :likings , :source => :user

  has_many :subscribings
  has_many :Subscribe_users, :through => :subscribings , :source => :user

	delegate :name, :to => :category, :prefix => true, :allow_nil => true
	# delegate :email, :to => :user, :prefix => true, :allow_nil => true

	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/      

  def comment_users
  	feedbacks.map{ |fe| fe.user }.uniq
  end
  
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

end
