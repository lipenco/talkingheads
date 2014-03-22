Talkingheads::Application.routes.draw do

  root "application#index"
  # root to: "application#index"

  resources :conferences do
      resources :talks
  end

  get '/auth/:provider/callback', to: 'sessions#create'

end
