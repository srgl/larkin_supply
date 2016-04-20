Rails.application.routes.draw do
  root 'orders#index'

  resources :orders do
    collection do
      get 'import'
      post 'import'
    end
  end

  resources :loads
end
