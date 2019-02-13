class Recipe < ApplicationRecord
  belongs_to :user, optional: true
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_one_attached :image

  accepts_nested_attributes_for :ingredients, allow_destroy: true
  accepts_nested_attributes_for :steps, allow_destroy: true

  MAX_IMAGE_SIZE = 5.megabytes
  before_validation :format_title_description
  validates :title, presence: true,
                    length: { maximum: 100 }
  validates :description, presence: true,
                          length: { maximum: 1500 }
  validate :correct_image_type
  validate :correct_image_size

  scope :published, -> { where(published: true) }

  private

    # Validates, Formats description before presisting to db.
    def format_title_description
      if description.present? && title.present?
        self.description = description.strip.capitalize
        self.title = title.strip.capitalize
      end
    end

    def correct_image_type
      if image.attached?
        if !image.content_type.in?(%w[image/jpg image/png])
          errors.add(:image, 'must be of content types: jpg, png')
        end
      end
    end

    def correct_image_size
      if image.attached?
        if image.byte_size > MAX_IMAGE_SIZE
          errors.add(:image, 'is too large, max file size is 5mb')
        end
      end
    end
end
