class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users
  has_many :messages, dependent: :destroy

  has_one_attached :avatar
  belongs_to :org_form, optional: true

  has_many :phones, dependent: :destroy
  has_many :karmas, dependent: :destroy

  def username
    name.presence || email
  end

  def total_karma
    karmas.sum(:point)
  end
end
