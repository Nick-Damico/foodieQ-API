class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :steps
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :description, presence: true,
                          length: { maximum: 1500 }

  before_validation :format_description_title

  private
  def format_description_title
    if !self.description.empty? && !self.title.empty?
      self.description = self.description.strip.capitalize
      self.title = self.title.strip.capitalize
    end
  end
end
