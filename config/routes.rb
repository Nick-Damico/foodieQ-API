Rails.application.routes.draw do
  root 'static#welcome'

  namespace :api do
    namespace :v1 do
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
