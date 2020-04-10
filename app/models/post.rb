class Post < ApplicationRecord
  has_rich_text :content
  belongs_to :user
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :cities
end
