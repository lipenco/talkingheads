collection @favourites

attributes :id, :title, :description, :video_url, :slides_url, :speaker,  :speaker_twitter, :conference_id, :favorites, :impressions_count, :comments_count
node(:favorited) {|talk| talk.favourites.where(user_id: current_user.id).length >0 }
