object @talk



attributes :id, :title, :video_url, :speaker, :slides_url, :conference_id, :description, :impressions_count
node(:favorited) { @talk.favourites.where(user_id: current_user.id).length >0 if current_user}
