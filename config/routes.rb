Rails.application.routes.draw do
  root to: 'toppage#home'
  get    '/signup', to: 'users#new'
  post   '/',       to: 'hotels#index'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/login',  to: 'sessions#destroy'
  
  resources :users
  resources :hotels
  resources :reservations
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
