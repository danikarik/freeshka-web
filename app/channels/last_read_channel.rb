class LastReadChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update(data)
    room_user = current_user.room_users.find_by(room_id: data['room_id'])
    room_user.update(last_read_at: Time.zone.now)
  end
end
