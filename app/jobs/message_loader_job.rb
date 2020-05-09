class MessageLoaderJob < ApplicationJob
  queue_as :default

  def perform(room, last_id, current_user)
    messages = room.messages
                   .where('id < ?', last_id)
                   .order(created_at: :desc).limit(10)

    ActionCable.server.broadcast "rooms:#{room.id}:data:#{current_user.id}", {
      messages: collect(messages),
      room_id: room.id,
      count: messages.count
    }
  end

  private

  def collect(messages)
    messages.map { |message| render(message) }
  end

  def render(message)
    ApplicationController.render(partial: 'messages/message',
                                 locals: { message: message })
  end
end
