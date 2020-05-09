class VoteRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "rooms:#{message.room.id}:karma", {
      id: message.id,
      karma: message.karma
    }
  end
end
