Rails.application.routes.draw do
  root 'lists#index'
  
  resources :lists do
    collection do
      get :cities
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
