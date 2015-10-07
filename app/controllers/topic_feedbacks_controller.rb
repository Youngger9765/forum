class TopicFeedbacksController < ApplicationController

	before_action :authenticate_user!

	before_action :set_topic_id

	def index
		@feedbacks = @topic.feedbacks

	end

	def show
		@feedback = @topic.feedbacks.find(params[:id])
	end

	def new
		@feedback = @topic.feedbacks.new
	end

	def create
		@feedback = @topic.feedbacks.build(feedback_params)
		@feedback.user = current_user

		if @feedback.save
			@topic.latest_feedback_time = @feedback.created_at
			@topic.save
			redirect_to topic_path(@topic)
			flash[:notice] = "Create Success"
			
		elsif 
			flash[:alert] = "Create Fail"
			render "new"
		end
	end

	def edit
		@feedback = @topic.feedbacks.find(params[:id])
	end

	def update
		@feedback = @topic.feedbacks.find(params[:id])

		if params[:destroy_logo] == "1"
            @feedback.logo = nil
        end

		if @feedback.update (feedback_params)
			flash[:notice] = "Feedback Update!"
			redirect_to topic_path(@topic)
			
		else
			flash[:alert] = "Feedback fail"
			render "edit"
		end
	end

	def destroy
		@feedback = Feedback.find(params[:id])
		@feedback.destroy
		#redirect_to topic_path(@topic)
		redirect_to :back
	end



	private

	def set_topic_id
		@topic= Topic.find(params[:topic_id] )
	end

	def feedback_params
		params.require(:feedback).permit(:content, :status, :logo)
	end


end
