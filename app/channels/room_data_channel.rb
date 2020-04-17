class RoomDataChannel < ApplicationCable::Channel
  def subscribed
    current_user.rooms.each do |room|
      stream_from "rooms:#{room.id}:data"
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def request_messages(data)
    @room = Room.find(data['room_id'])
    after = data['last_id']

    MessageLoaderJob.perform_later(@room, after, current_user)
  end
end
