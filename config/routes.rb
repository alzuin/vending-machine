Rails.application.routes.draw do
  resources :products
  resources :coins, only: [:index, :edit, :update]

  root to: "product#index"
end
