class Admin::TopicsController < ApplicationController

	#後台登入
	before_action :authenticate_user! 

	#檢查權限
	before_action :check_admin

	layout "admin"

	def index
		@topics = Topic.where(:category => nil)
		@users = User.all

		if params[:id]
  		@topic = Topic.find( params[:id] )
  	end
	end

	def update
		Topic.find(params[:id]).update(topic_params)
		flash[:notice] = "Update Success!"
		redirect_to admin_topics_path		
	end

	protected

	def topic_params
		params.require(:topic).permit(:category_id, :description)
	end


end
