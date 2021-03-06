Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :index], path: :pals, as: :pals do
    # get '/inboxes/edit', to: 'users#edit'
    patch '/inboxes', to: 'users#update'
    patch '/inboxes/avatar', to: 'users#update_avatar', as: :update_avatar
    resources :inboxes, only: [:index, :show]
  end

  resources :inboxes, only: [:new, :create, :destroy] do
    resources :letters, only: [:new, :create, :update]
  end

  resources :letter, only: [:index, :show, :update]
end
