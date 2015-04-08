Rails.application.routes.draw do

  resources :fellowships
  devise_for :users
  resources :artifacts

    # IF user session exists
  authenticated :user do
    root to: 'artifacts#index', as: "authenticated_root"
  end
  root to: 'info#home'
  
  get 'tags/:tag', to: 'artifacts#index', as: :tag

end
