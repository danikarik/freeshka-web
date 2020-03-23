Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users, path: 'auth', path_names: { sign_in: 'login',
                                                 sign_up: 'register',
                                                 sign_out: 'logout' }

  get 'home/index'
end
