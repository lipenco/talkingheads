collection @user_list

extends "conferences/_base"


child :talks do
  attributes :id, :title, :description, :video_url, :conference_id
end
