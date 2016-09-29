class Post < ActiveRecord::Base

## Filters

  belongs_to :blog


## Scope
  # Return posts by creation date, first first
  default_scope -> {order(created_at: :desc)}


## Validations
  # Post has always a blog parent
  validates :blog_id, presence: true

  # Title and content should be present and restricted in length
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 5000 }

end
