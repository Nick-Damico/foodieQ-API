class RecipeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :description, :links, :created_at

  has_many :ingredients, serializer: IngredientSerializer
  has_many :steps, serializer: StepSerializer
  has_one  :image

  def links
    resource_links = {}
    resource_links[:image_url] = rails_blob_path(object.image) if object.image_attachment
    resource_links[:recipe_url] = api_v1_recipe_url(object)
    resource_links
  end
end
