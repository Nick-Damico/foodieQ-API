class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :email, :links

  has_many :recipes

  def links
    resource_links = {}
    resource_links["self"] = rails_blob_path(object.avatar) if object.avatar_attachment
    resource_links
  end
end
