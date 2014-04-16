collection @talks


attributes :id, :title, :video_url, :speaker, :slides_url, :conference_id, :description, :favorites, :views_count
node(:favorited) {|talk| talk.favourites.where(user_id: current_user.id).length >0  if current_user }
