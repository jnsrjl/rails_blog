class Blog < ActiveRecord::Base
  # TODO : Add dependency to posts
  belongs_to :user

## Scope

  # Return blogs by creation date, first first
  default_scope -> {order(created_at: :desc)}

## Validations

  # User_id: present
  validates :user_id, presence: true

  # Name: present and between 1 - 30 chars
  validates :name, presence: true, length: { minimum: 1, maximum: 30 }
end
