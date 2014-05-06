collection @user_list

extends "conferences/_base"


child :talks do
  attributes :id, :title, :description, :video_url, :slides_url, :speaker, :speaker_twitter, :conference_id, :favorites, :impressions_count, :comments_count
end
