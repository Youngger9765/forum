class Feedback < ActiveRecord::Base

	validates_presence_of :content

	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

	belongs_to :topic,  :counter_cache => true # topics#feedbacks_count
	belongs_to :user

  def created_at_format
    self.created_at.strftime('%b %d %Y %H:%M')
  end

end