Rails.application.routes.draw do
  root 'orders#index'

  concern :deletable do
    delete :index, on: :collection, action: :delete
  end

  resources :orders, except: [:destroy, :show], concerns: :deletable do
    collection do
      get 'import'
      post 'import'
      post 'lookup'
    end
  end

  resources :loads, except: [:destroy, :show], concerns: :deletable do
    member do
      post 'orders'
      delete 'orders'
    end
  end
end
