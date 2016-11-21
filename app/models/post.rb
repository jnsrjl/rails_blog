class Post < ActiveRecord::Base

## Filters

  belongs_to :blog


## Scope

  # Return posts by creation date, first first
  default_scope -> {order(created_at: :desc)}

  # Add CarrierWave uploader for images
  mount_uploader :image, PostimageUploader


## Validations

  # Post has always a blog parent
  validates :blog_id, presence: true

  # Title and content should be present and restricted in length
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 5000 }

  # Image size shouldn't be too much
  validate :image_size


## Private sector

  private

    # Add error if image size over 3MB
    def image_size
      if image.size > 3.megabytes
        errors.add(:image, "image too heavy (3MB max)")
      end
    end

end
