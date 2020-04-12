class Post < ApplicationRecord
  validates :title, :content, :categories, :cities, presence: true

  has_rich_text :content
  belongs_to :user
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :cities
end