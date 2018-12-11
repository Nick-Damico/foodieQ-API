class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at

  has_many :ingredients
  has_many :steps
end
