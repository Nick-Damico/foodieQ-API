Rails.application.routes.draw do
  root 'static#welcome'

  namespace :api do
    namespace :v1 do
      resources :recipes, only: [:index]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
