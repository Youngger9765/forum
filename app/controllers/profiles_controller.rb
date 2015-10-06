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

		@user = User.find(params[:id])

		@profile =Profile.find_by_user_id(params[:id])

		if @profile == nil
			@profile = Profile.new
		else
			#@profile 進入edit mode

		end



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

	def create
		@profile = Profile.new(profile_params)
		@profile.user_id = current_user.id

		@profile.save
		redirect_to profile_path(current_user.id)
		flash[:notice] = "Create Success"
	end	

	def update
		
		@profile =Profile.find_by_user_id(current_user.id)
		@profile.update(profile_params)
		flash[:notice] = "Update Success!"
		redirect_to profile_path(current_user.id)

	end

	private

	def profile_params
		params.require(:profile).permit(:description)

	end


end
