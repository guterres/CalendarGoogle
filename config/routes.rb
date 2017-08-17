Rails.application.routes.draw do
  root to: 'home#index'
  get '/', to: 'home#index', as: 'home'
  get '/auth', to: 'home#auth', as: 'auth'
  get '/callback', to: 'home#callback', as: 'callback'
  get '/logout', to: 'home#logout', as: 'logout'

  resources :events, except: [:show, :edit, :update, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
