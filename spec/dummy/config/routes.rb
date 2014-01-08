Rails.application.routes.draw do
  resources :tests
  devise_for :users
  resource :user_session

  root to: 'tests#index'
end
