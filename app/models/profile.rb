class Profile < ActiveRecord::Base
	validates_presence_of :user_id

	belongs_to :user

  def admin?
    self.role == "admin"
  end
  
end
