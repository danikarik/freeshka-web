class MessageLoaderJob < ApplicationJob
  queue_as :default

  def perform(room, after, current_user)
    messages = room.messages.where('id < ?', after).order(created_at: :desc).limit(10)

    ActionCable.server.broadcast "rooms:#{room.id}:data", {
      messages: collect(messages, current_user.id),
      room_id: room.id,
      count: messages.count
    }
  end

  private

  def collect(messages, current_user_id)
    messages.map { |message| render(message, current_user_id) }
  end

  def render(message, current_user_id)
    ApplicationController.render(partial: 'messages/message',
                                 locals: { message: message,
                                           current_user_id: current_user_id })
  end
end
