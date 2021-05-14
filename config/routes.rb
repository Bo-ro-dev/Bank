Rails.application.routes.draw do
  root to: 'accounts#show'

  resources :accounts
  post '/transfer_money', to: 'accounts#transfer_money'
  get 'users/show'
  devise_for :users
  get '/test', to: 'accounts#test'
  resources :requests, only: [:index, :new, :create, :destroy] do
    member do
      post :accept
      post :reject
    end
  end
  resources :operations, only: [:create, :index, :new]
  resources :user_mfa_session, only: [:new, :create]

end
