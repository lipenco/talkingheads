collection @favourites

attributes :id, :title, :description, :video_url, :slides_url, :speaker, :conference_id, :favorites, :impressions_count, :comments_count
node(:favorited) {|talk| talk.favourites.where(user_id: current_user.id).length >0 }
