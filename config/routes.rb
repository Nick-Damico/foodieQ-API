Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  root 'static#welcome'

  namespace :api do
    namespace :v1 do
      post 'auth', to: "authentication#create"
      post 'auth/google', to: "authentication#google"
      post '/signup' => 'users#create'
      post '/login', to: 'authentication#create'
      delete '/logout', to: 'authentication#destroy'
      resources :recipes
      resources :users do
        resources :recipes
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
