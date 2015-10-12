class TopicFeedbacksController < ApplicationController

	before_action :authenticate_user!
	before_action :set_topic

	def index
	end

	def show
		@feedback = @topic.feedbacks.find(params[:id])
	end

	def new
		@feedback = @topic.feedbacks.new
	end

	def create
		# @feedbacks = @topic.feedbacks.all
		@feedback = @topic.feedbacks.build(feedback_params)
		@feedback.user = current_user

		if @feedback.save
			@topic.latest_feedback_time = @feedback.created_at
			@topic.save

			respond_to do |format|
      	format.html{ redirect_to :back}
      	format.js  # create.js.erb
    	end
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
		if current_user.admin?
			@feedback = Feedback.find(params[:id])
		else
			@feedback = current_user.feedbacks.find(params[:id])
		end

		@feedback.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.js # destroy.js.erb
    end

	end

	private

	def set_topic
		@topic= Topic.find(params[:topic_id] )
	end

	def feedback_params
		params.require(:feedback).permit(:content, :status, :logo)
	end


end
