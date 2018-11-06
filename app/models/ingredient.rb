class Ingredient < ApplicationRecord
  validates :name, presence: true,
                   length: { minimum: 8, maximum: 200 }
end
