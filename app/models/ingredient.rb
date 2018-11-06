class Ingredient < ApplicationRecord
  belongs_to :recipe
  validates :name, presence: true,
                   length: { minimum: 8, maximum: 200 }
end
