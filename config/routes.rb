Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get '/yourlikes', to: 'profiles#liked_artifacts'

  get 'profiles/show'

  resources :fellowships do
    member do
      put 'join', to: 'fellowships#join'
      put 'leave', to: 'fellowships#leave'
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'registrations'}

  resources :artifacts do 
    member do
      put "like", to: 'artifacts#like'
      put 'dislike', to: 'artifacts#unlike'
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

  match 'f/:id' => 'fellowships#show', as: 'view_fellowship', via: [:get, :post]

  # GBTT horrible routing!!!!!! Can't get to artifacts controller

end
