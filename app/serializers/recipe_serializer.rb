class RecipeSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :description, :links, :created_at

  has_many :ingredients, serializer: IngredientSerializer
  has_many :steps, serializer: StepSerializer
  has_one  :image

  def links
    {
      image_url: rails_blob_path(object.image)
    }
  end
end
