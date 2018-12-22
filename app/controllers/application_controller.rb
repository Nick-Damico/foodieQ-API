class ApplicationController < ActionController::API
  include Pagy::Backend
  include UserHelper
  include RecipeHelper
end
