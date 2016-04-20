Rails.application.routes.draw do
  root 'orders#index'

  resources :orders do
    collection do
      get 'import'
      post 'import'
      delete 'bulk_delete'
    end
  end

  resources :loads
end
