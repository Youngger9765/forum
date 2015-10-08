module TopicsHelper

  #Like
  def topic_like_class(topic)
    if current_user && current_user.like_topic?(topic)
      "btn-info"
    else
      "btn-default"
    end    
  end

  def like_word(topic)   
    if current_user && current_user.like_topic?(topic) 
      "取消讚"
    else 
      "按個讚吧"
    end 
      
  end
end
