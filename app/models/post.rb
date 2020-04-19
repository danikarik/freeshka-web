class Post < ApplicationRecord
  validates :title, :content, :categories, :cities, presence: true
  validates :title, uniqueness: { case_sensitive: false }

  has_rich_text :content

  belongs_to :user
  has_one :room, dependent: :destroy
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :cities
end
