class Post < ApplicationRecord
  validates :title, :content, :categories, :cities, presence: true
  validates :title, uniqueness: { case_sensitive: false }

  belongs_to :user
  has_rich_text :content

  has_one :room, dependent: :destroy
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :cities

  has_many_attached :attachments, dependent: :purge

  def room_users
    room.room_users.where.not(user_id: user.id)
  end
end
