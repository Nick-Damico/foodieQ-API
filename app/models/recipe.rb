class Recipe < ApplicationRecord
  belongs_to :user, optional: true
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  accepts_nested_attributes_for :ingredients, allow_destroy: true
  accepts_nested_attributes_for :steps, allow_destroy: true

  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :description, presence: true,
                          length: { maximum: 1500 }

  before_validation :format_title_description

  private
  # Validates, Formats description before presisting to db.
  def format_title_description
    if self.description.present? && self.title.present?
      self.description = self.description.strip.capitalize
      self.title = self.title.strip.capitalize
    end
  end
end
