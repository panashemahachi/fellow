Rails.application.routes.draw do

  resources :fellowships
  devise_for :users
  resources :artifacts
  root to: 'info#home'
  get 'tags/:tag', to: 'artifacts#index', as: :tag

end
