Rails.application.routes.draw do
  resources :orders do
    collection do
      get 'import'
      post 'import'
    end
  end

  root 'orders#index'
end
