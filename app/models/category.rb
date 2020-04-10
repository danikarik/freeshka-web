class Category < ApplicationRecord
  has_many :categories, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category', optional: true
  has_and_belongs_to_many :posts
end
