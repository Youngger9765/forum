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

  #favorite
  def topic_favorite_class(topic)
    if current_user && current_user.like_topic?(topic)
      "btn-info"
    else
      "btn-default"
    end   
  end

  def favorite_word(topic)   
    if current_user && current_user.like_topic?(topic) 
      "取消收藏"
    else 
      "收藏"
    end 
  end

  #subscribe
  def topic_subscribe_class(topic)
    if current_user && current_user.subscribe_topic?(topic)
      "btn-info"
    else
      "btn-default"
    end   
  end

  def subscribe_word(topic)   
    if current_user && current_user.subscribe_topic?(topic) 
      "取消訂閱"
    else 
      "訂閱"
    end 
  end

end
