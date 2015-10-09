class ProfilesController < ApplicationController

	def show
		@user = User.find_by_username(params[:id])
		@profile = @user.profile || Profile.new

		@topics = @user.topics
		@feedbacks = @user.feedbacks

		if current_user && ( @user == current_user || current_user.admin? )
			@favorite_topics = @user.favorite_topics
			@subscribe_topics = @user.subscribe_topics
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
