collection @favourites

attributes :id, :title, :description, :video_url, :slides_url, :speaker, :conference_id
node(:favorited) {|talk| talk.favourites.where(user_id: current_user.id).length >0 }
