Rails.application.routes.draw do

  resources :sellings, only: [:index, :create]
  resources :products
  resources :coins, only: [:index, :edit, :update]

  root to: "sellings#index"
end
