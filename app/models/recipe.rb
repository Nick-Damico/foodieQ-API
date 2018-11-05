class Recipe < ApplicationRecord
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :description, presence: true,
                          length: { maximum: 1500 }

  before_validation :capitalize_description

  private
  def capitalize_description
    if !self.description.empty?
      self.description = self.description.capitalize
    end
  end
end
