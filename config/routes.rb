Rails.application.routes.draw do
  root 'orders#index'

  resources :orders, except: [:destroy, :show] do
    collection do
      get 'import'
      post 'import'
      delete 'bulk_delete'
    end
  end

  resources :loads do
    collection do
      #create
    end
  end
end
