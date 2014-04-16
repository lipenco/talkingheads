collection @user_list

extends "conferences/_base"


child :talks do
  attributes :id, :title, :description, :video_url, :slides_url, :speaker, :conference_id, :favorites, :views_count
end
