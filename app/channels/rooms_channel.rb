class RoomsChannel < ApplicationCable::Channel
  def subscribed
    current_user.rooms.each do |room|
      stream_from "rooms:#{room.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
    @room = Room.find(data['room_id'])
    message = @room.messages.create(body: data['body'], user: current_user)

    MessageRelayJob.perform_later(message, current_user)
  end

  def send_last_read(data)
    room_user = current_user.room_users.find_by(room_id: data['room_id'])
    room_user.update(last_read_at: Time.zone.now)
  end
end
