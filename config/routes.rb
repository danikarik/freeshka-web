Rails.application.routes.draw do
  resources :posts do
    member do
      delete '/attachments/:attachment_id', to: 'posts#delete_attachment',
                                            as: 'delete_attachment'
    end
  end

  resources :rooms do
    resource :room_user
    resources :messages
  end

  devise_for :users,
             path: '',
             controllers: { registrations: 'users/registrations' },
             path_names: { sign_in: 'login',
                           sign_out: 'logout',
                           sign_up: 'register',
                           edit: 'settings' }
  devise_scope :user do
    delete '/settings/avatar', to: 'users/registrations#delete_avatar',
                               as: 'delete_avatar'
  end

  root to: 'home#index'

  get '/', to: 'home#index', as: 'home'
  get '/profile', to: 'profile#index', as: 'profile'
end
