class City < ApplicationRecord
  has_many :cities, class_name: 'City', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'City', optional: true
  has_and_belongs_to_many :posts
end
