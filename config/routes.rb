Talkingheads::Application.routes.draw do

  root "application#index"
  # root to: "application#index"

  resources :conferences do
    resources :talks
  end

  resources :talks do
    resources :comments
  end

  # resources :users do
  #   resources :conferences
  # end

  # get '/auth/:provider/callback', to: 'sessions#create'

  get 'user_list', to: 'conferences#user_list'

  get 'favourites', to: 'favourites#list'

  get 'search/:q', to: 'talks#search'

  get 'praginate/:p', to: 'conferences#praginate'

  # get 'favorites', to: 'favourites#current_user'


  post 'talks/:talk_id/favorites', to: 'favourites#create'

  delete 'talks/:talk_id/favorites', to: 'favourites#destroy'


  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'logout', to: 'sessions#destroy', via: [:get, :post]








end
