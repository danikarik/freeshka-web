Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'settings' }
  
  root to: 'home#index'

  get '/', to: 'home#index', as: 'home'
  get '/profile', to: 'profile#index', as: 'profile'
end
