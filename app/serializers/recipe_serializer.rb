class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at

  has_many :ingredients, serializer: IngredientSerializer
  has_many :steps

  link(:self) { api_v1_recipe_url(object.id) }
end
