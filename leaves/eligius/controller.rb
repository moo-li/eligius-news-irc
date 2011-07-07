# Controller for the Eligius leaf.

class Controller < Autumn::Leaf
  
  # Typing "=about" displays some basic information about this leaf.
  def about_command(stem, sender, reply_to, msg)
    # This method renders the file "about.txt.erb"
  end
  
  # Typing "=news" summarises recent news
  def news_command(stem, sender, reply_to, msg)
    send_news reply_to
  end
  
  # Typing "=private" summarises recent news
  def private_command(stem, sender, reply_to, msg)
    send_news sender[:nick]
  end

  # Invoked when the leaf receives a private (whispered) message. +sender+ is
  # a sender hash.
  def did_receive_private_message(stem, sender, msg)
    send_news sender[:nick]
  end

  def send_news(target)
    stems.message "Here is the news", target
  end
  
    # Override Leaf's someone_did_change_topic method to write to our db
  def someone_did_change_topic(stem, person, channel, topic)
    news_item = NewsItem.new
    news_item.message = topic
    news_item.updated_at = Time.now
    result = news_item.save

    if result then
      result_message = 'Added'
    else
      result_message = 'Failed to add'
    end

    stems.message "#{result_message} #{topic} to database."
  end
end
