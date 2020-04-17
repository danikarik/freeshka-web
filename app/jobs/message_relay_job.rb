class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message, current_user)
    ActionCable.server.broadcast "rooms:#{message.room.id}", {
      message: MessagesController.render(message, locals: { current_user_id: current_user.id }),
      divider: ApplicationController.render(partial: 'messages/divider'),
      user: message.user.email,
      body: message.body,
      room_id: message.room.id
    }
  end
end
