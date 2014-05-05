object @single

extends "conferences/_base"


child :talks do
  attributes :id, :title, :description, :video_url, :conference_id, :speaker, :slides_url, :favorites, :impressions_count, :comments_count
  node(:favorited) {|talk| talk.favourites.where(user_id: current_user.id).length >0  if current_user }
end
