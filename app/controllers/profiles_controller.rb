class ProfilesController < ApplicationController

	def index

		#只允許 admin 進入
		unless current_user.admin?
			#flash[:alert] ="No Permission!"
			raise ActiveRecord::RecordNotFound
		end

		if current_user && current_user.admin?
			@profile = User.all			
		elsif current_user
			@profile = User.where(:id => current_user.id)
		end								
	end

	def show
		@user = User.find(params[:id])
		@profile = @user.profile || Profile.new

		@topics = @user.topics
		@feedbacks = @user.feedbacks

		if current_user && ( @user == current_user || current_user.admin? )

		else
			@topics = @topics.where(:status => "published")
			@feedbacks = @feedbacks.where(:status => "published")
		end
	end

	def create
		@profile = Profile.new(profile_params)
		@profile.user = current_user

		@profile.save

		flash[:notice] = "Create Success"
		redirect_to profile_path(current_user)
	end	

	def update
		@profile = current_user.profile		
		@profile.update(profile_params)

		flash[:notice] = "Update Success!"
		redirect_to profile_path(current_user)
	end

	private

	def profile_params
		params.require(:profile).permit(:description)
	end

end
