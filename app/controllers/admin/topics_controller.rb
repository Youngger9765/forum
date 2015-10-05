class Admin::TopicsController < ApplicationController

	#後台登入
	before_action :authenticate_user! 

	#檢查權限
	before_action :check_admin

	layout "admin"

	def index
		@topics = Topic.where(:category => nil)
		@user = User.all

		if params[:id]
  			@topic = Topic.find( params[:id] )
  		else
			
  		end
	end

	def update
		Topic.find(params[:id]).update(:category_id => params[:topic][:category_id])
		flash[:notice] = "Update Success!"
		redirect_to admin_topics_path		
	end
	

	protected

	def check_admin
		unless current_user.admin?
			#flash[:alert] ="No Permission!"
			raise ActiveRecord::RecordNotFound
		end
		
	end


end
