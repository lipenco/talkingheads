object @single

extends "conferences/_base"


child :talks do
  attributes :id, :title, :description, :video_url
end