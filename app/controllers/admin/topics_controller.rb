class Admin::TopicsController < ApplicationController

	#後台登入
	before_action :authenticate_user! 

	#檢查權限
	before_action :check_admin

	layout "admin"

	def index
		@topics = Topic.all
		@user = User.all
	end

	protected

	def check_admin
		unless current_user.admin?
			#flash[:alert] ="No Permission!"
			raise ActiveRecord::RecordNotFound
		end
		
	end


end
