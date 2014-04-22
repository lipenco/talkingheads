object @talk



attributes :id, :title, :video_url, :speaker, :slides_url, :conference_id, :description, :impressions_count, :comments_count
node(:favorited) { @talk.favourites.where(user_id: current_user.id).length >0 if current_user}


child :comments do
  attributes :id, :content, :user_id, :talk_id
end
