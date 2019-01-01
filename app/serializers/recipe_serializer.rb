class RecipeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :description, :links, :created_at

  has_many :ingredients, serializer: IngredientSerializer
  has_many :steps, serializer: StepSerializer

  def links
    resource_links = {}
    resource_links[:self]       = api_v1_recipe_url(object)
    resource_links
  end
end
