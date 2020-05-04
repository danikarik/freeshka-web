class Phone < ApplicationRecord
  belongs_to :user
  validates :number, uniqueness: { scope: [:user_id] }
end
