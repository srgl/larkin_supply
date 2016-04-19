Rails.application.routes.draw do
  resources :orders

  root 'orders#index'
end
