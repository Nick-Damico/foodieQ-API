Rails.application.routes.draw do
  root 'static#welcome'

  namespace :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
      post '/signup' => 'users#new'
      post '/login' => 'sessions#new'

      resources :users
      resources :recipes
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
