collection @conferences

attributes :id, :name, :tags, :date, :organizer, :description, :place, :created_at, :updated_at


node do |conference|
  {  
     :created_at_formatted => conference.created_at.strftime("%m/%d/%Y"),
     :updated_at_formatted => time_ago_in_words(conference.updated_at)
  }
end
