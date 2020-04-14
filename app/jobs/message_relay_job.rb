class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "rooms:#{message.room.id}", {
      message: MessagesController.render(message),
      user: message.user.email,
      body: message.body,
      room_id: message.room.id
    }
  end
end
