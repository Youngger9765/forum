class TopicsController < ApplicationController

	before_action :authenticate_user!, :except => [:index]

	before_action :topic_params_id, :only =>[ :show, :update, :destroy]

	def index
		@topics = Topic.all

		#如果出現 tipic_id 代表針對個案id處理edit
		if params[:topic_id]
  			@topic = Topic.find( params[:topic_id] )
  		else
			@topic = Topic.new
  		end

	end

	def new
		@topic = Topic.new
	end

	def create

		@topic = Topic.new( topic_params)
		if @topic.save
			redirect_to topics_path
			flash[:notice] = "Create Success"
		elsif 
			@topics = Topic.all
			flash[:alert] = "Create Fail"
			render "index"
		end

	end	

	def show

	end



	def update
		if @topic.update(topic_params)
			flash[:notice] = "Update Success!"
			redirect_to topics_path
		else 
			@topics = Topic.all
			flash[:alert] = "Update Fail"
			render "index"
		end
	end

	def destroy
		@topic.destroy
		flash[:alert] = "DELETE DONE!"
		redirect_to topics_path
	end


	private

	def topic_params
		params.require(:topic).permit(:name, :content)
	end

	def topic_params_id
		@topic = Topic.find(params[:id])
	end


end