object @single

extends "conferences/_base"


child :talks do
  attributes :id, :title, :description, :video_url, :conference_id, :speaker, :slides_url
end
