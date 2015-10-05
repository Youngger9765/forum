class User < ActiveRecord::Base
  validates_presence_of :email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Gravtastic
  gravtastic

  has_many :topics 
  has_many :feedbacks

  has_one :profile

  def admin?
  	self.role == "admin"
  end

end
