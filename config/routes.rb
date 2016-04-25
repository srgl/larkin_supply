Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'

  concern :deletable do
    delete :index, on: :collection, action: :delete
  end

  resources :orders, except: [:destroy, :edit], concerns: :deletable do
    collection do
      get 'import'
      post 'import'
    end
  end

  resources :loads, except: [:destroy, :edit], concerns: :deletable do
    member do
      get 'download'
    end
  end
end
