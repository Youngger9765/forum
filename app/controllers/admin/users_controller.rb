class Admin::UsersController < ApplicationController

	#後台登入
	before_action :authenticate_user! 

	#檢查權限
	before_action :check_admin

	layout "admin"

	def index
		
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		User.find(params[:id]).update(user_params)
		flash[:notice] = "Update Success!"
		redirect_to admin_topics_path		
	end

	private

	def check_admin
		unless current_user.admin?
			#flash[:alert] ="No Permission!"
			raise ActiveRecord::RecordNotFound
		end
	end

	def user_params
		params.require(:user).permit(:role)
	end
		

end
