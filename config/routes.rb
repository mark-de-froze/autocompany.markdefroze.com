Rails.application.routes.draw do

  root to: 'welcome#index'

  get 'dashboard', to: 'dashboard#index'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  namespace :admin do
    resources :users
    resources :roles
  end

  resources :clients
  resources :cars

  resources :orders do
    resources :tasks
    resources :materials
  end

  get 'reports', to: 'reports#index'

  namespace :reports do
    resources :orders
  end

  resources :workers

  resources :parts do
    resources :histories
  end

  resources :oils do
    resources :histories
  end

  resources :services
  resources :jobs

end
