class ProfilesController < ApplicationController

	def index

		#只允許 admin 進入
		unless current_user.admin?
			#flash[:alert] ="No Permission!"
			raise ActiveRecord::RecordNotFound
		end

		if current_user && current_user.role !="admin"
			@profile = User.where(:id => current_user.id)
		elsif current_user.role == "admin"
			@profile =User.all
		else

		end
								
	end

	def show
		@profile = User.find(params[:id])

		if current_user == nil
			@topics = Topic.where(:user_id => params[:id], :status => "published")
			@feedbacks = Feedback.where(:status => "published" )
		
		elsif current_user.id.to_s != params[:id] && current_user.role != "admin"
			@topics = Topic.where(:user_id => params[:id], :status => "published")
			@feedbacks = Feedback.where(:user_id => params[:id], :status => "published")
		
		elsif current_user.role	== "admin" || current_user.id.to_s == params[:id]
			@topics = Topic.where(:user_id => params[:id])
			@feedbacks = Feedback.where(:user_id => params[:id])
			
		end

	end

end
