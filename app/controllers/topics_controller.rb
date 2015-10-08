class TopicsController < ApplicationController

	before_action :authenticate_user!, :except => [:index,:show, :about]

	before_action :set_topic, :only =>[ :update, :destroy]

	def index
		#如果出現 tipic_id 代表針對個案id處理edit
		if params[:topic_id]
		  @topic = Topic.find( params[:topic_id] )
		else
			@topic = Topic.new
		end

    if params[:tag_id]
      @topics = Tag.find(params[:tag_id]).topics
    elsif params[:category]
      @topics = @topics.where(:category_id => params[:category])
    else
      @topics = Topic.all
    end

    if current_user && current_user.admin?
      @topics = @topics.all
    elsif current_user
      @topics = @topics.where("user_id = ? OR status = ?", current_user.id , "published")    
    else
      @topics = @topics.where(:status => "published")
    end

    if ["name", "created_at", "feedbacks_count", "latest_feedback_time"].include?( params[:order] )
		  sort_by = (params[:order]+" DESC")	  		
    else
      sort_by = "id DESC"
    end
  		
		@topics = @topics.order(sort_by).page(params[:page]).per(5) 
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

    if current_user && current_user.admin?
      @feedbacks = @topic.feedbacks.all
    elsif current_user
      @feedbacks = @topic.feedbacks.where("user_id = ? OR status =?", current_user.id,"published")
    else
      @feedbacks = @topic.feedbacks.where(:status => "published" )
    end

		@feedback = Feedback.new
	end

	def update
		if params[:destroy_logo] == "1"
      		@topic.logo = nil
	    end

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
		redirect_to :back
	end

	def about
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

  def favorite

    @topic = Topic.find(params[:id])
    if current_user && !current_user.favorite_topic?(@topic)
      current_user.favorite_topics << @topic    

    elsif current_user && current_user.favorite_topic?(@topic)
      current_user.favorite_topics.delete(@topic) 
    end

    respond_to do |format|
      format.html{ redirect_to :back}
      format.js
    end

  end

  def like
    @topic = Topic.find(params[:id])
    if current_user && !current_user.like_topic?(@topic)
      current_user.like_topics << @topic      
    elsif current_user && current_user.like_topic?(@topic)
      current_user.like_topics.delete(@topic)  
    end

    respond_to do |format|
      format.html{ redirect_to :back}
      format.js
    end
    
  end

  def subscribe
    @topic = Topic.find(params[:id])
    if current_user && !current_user.subscribings.find_by(:topic_id => params[:id])
      @subscribe = current_user.subscribings.new
      @subscribe.topic_id = params[:id]
      @subscribe.save
      flash[:notice] = "成功訂閱了"
      redirect_to topic_path(params[:id])
    else
      flash[:alert] = "已經訂閱了"
      redirect_to topic_path(params[:id])
    end



  end

	private

	def topic_params
		params.require(:topic).permit(:name, :content, :category_id, :status, :tag_list, :logo)
	end

	def set_topic
		if current_user.admin? 
			@topic = Topic.find(params[:id])		
		else
			@topic = current_user.topics.find(params[:id])
		end	
	end

end
