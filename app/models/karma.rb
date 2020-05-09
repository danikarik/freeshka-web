class Karma < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :reviewer, class_name: 'User'
  belongs_to :room, optional: true
  belongs_to :post, optional: true
end
