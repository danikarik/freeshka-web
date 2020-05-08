class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  def karma
    user.karmas.where(message_id: id).sum(:point)
  end
end
