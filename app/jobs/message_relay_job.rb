class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "rooms:#{message.room.id}", {
      message: ApplicationController.render(partial: 'messages/message',
                                            locals: { message: message }),
      divider: ApplicationController.render(partial: 'messages/divider'),
      user: message.user,
      body: message.body,
      room_id: message.room.id
    }
  end
end
