class TopicsController < ApplicationController

	before_action :authenticate_user!, :except => [:index,:show]

	before_action :topic_params_id, :only =>[ :update, :destroy]

	def index
		@topics = Topic.order("id DESC").page(params[:page]).per(5)

		#如果出現 tipic_id 代表針對個案id處理edit
		if params[:topic_id]
  			@topic = Topic.find( params[:topic_id] )
  		else
			@topic = Topic.new
  		end

  		if params[:order] 
  			sort_by = (params[:order]+" DESC")
  			@topics = Topic.order(sort_by).page(params[:page]).per(5) 
  		end



	end

	def new
		@topic = Topic.new
	end

	def create

		@topic = Topic.new(topic_params)
		@topic.user = current_user

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
		@topic = Topic.find(params[:id])
		@feedbacks = @topic.feedbacks
		@feedback = Feedback.new
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

	def aboutsite
		@user = User.all
		@topics =Topic.all
		@feedbacks = Feedback.all
	end

	def bulk_update

		ids =Array(params[:ids])

		topics = ids.map{|i| Topic.find_by_id(i)}.compact
		
		if params[:commit] == "Delete"
			topics.each {|t| t.destroy}
		elsif params[:commit] == "Publish" 
			topics.each {|t| t.update(:status => "published")}
		end

		redirect_to :back

	end


	private

	def topic_params
		params.require(:topic).permit(:name, :content, :category_id, :status)
	end

	def topic_params_id
		if current_user == nil ||current_user.admin? 
			@topic = Topic.find(params[:id])
		
		else
			if current_user.topics.find(params[:id])
				@topic = current_user.topics.find(params[:id])
			else
				flash[:alert] = "You don't have the permission!"
				redirect_to	
			end		
		end
	end


end
