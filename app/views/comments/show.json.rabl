object @comment

attributes :id, :content, :user_id, :talk_id, :author_name, :author_image


node do |comment|
  {
     :created_at_formatted => comment.created_at.strftime("%m/%d/%Y"),
     :updated_at_formatted => time_ago_in_words(comment.updated_at)
  }
end
