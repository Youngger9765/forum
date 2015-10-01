class TopicFeedbacksController < ApplicationController

	before_action :set_topic_id

	def index
		@feedbacks = @topic.feedbacks
	end

	def show
		@feedback = @topic.feedbacks.find( params[:id])
	end



	private

	def set_topic_id
		@topic= Topic.find( params[:topic_id] )
	end


end
