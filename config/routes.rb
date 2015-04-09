Rails.application.routes.draw do

  get 'profiles/show'

  resources :fellowships

  devise_for :users

  resources :artifacts do 
    member do
      put "like", to: 'artifacts#like'
      put 'unlike', to: 'artifacts#unlike'
    end
  end

    # IF user session exists
  authenticated :user do
    root to: 'artifacts#index', as: "authenticated_root"
  end
  root to: 'info#home'
  
  get 't/:tag', to: 'artifacts#index', as: :tag

  get '/:id', to: 'profiles#show', as: :profile_link

  post '/follow_user/:id', to: 'relationships#follow', as: :follow_user
  post '/unfollow_user/:id', to: 'relationships#unfollow', as: :unfollow_user

    match 'f/:id' => 'fellowships#show', :as => 'view_fellowship', via: [:get, :post]

end
