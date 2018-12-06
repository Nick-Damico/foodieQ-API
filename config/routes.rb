Rails.application.routes.draw do
  devise_for :users
  root 'static#welcome'

  namespace :api do
    namespace :v1 do
      post :auth, to: "authentication#create"
      post '/signup' => 'users#create'
      post '/login' => 'user_token#create'

      resources :recipes
      resources :users do
        resources :recipes
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
