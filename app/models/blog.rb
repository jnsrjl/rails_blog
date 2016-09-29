class Blog < ActiveRecord::Base

## Filters

  belongs_to :user

  # User gets killed -> blog dies -> posts die #natural_selection
  has_many :posts, dependent: :destroy


## Scope

  # Return blogs by creation date, first first
  default_scope -> {order(created_at: :desc)}


## Validations

  # User_id: present
  validates :user_id, presence: true

  # Name: present and between 1 - 30 chars
  validates :name, presence: true, length: { minimum: 1, maximum: 30 }

end
