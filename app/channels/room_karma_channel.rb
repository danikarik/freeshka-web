class RoomKarmaChannel < ApplicationCable::Channel
  def subscribed
    current_user.rooms.each do |room|
      stream_from "rooms:#{room.id}:karma"
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def upvote_message(data)
    message = Message.find(data['message_id'])
    return unless message

    calc_karma(message, data)
    VoteRelayJob.perform_later(message)
  end

  private

  def calc_karma(message, data)
    karma = Karma.find_by(user_id: data['user_id'],
                          reviewer_id: data['reviewer_id'],
                          message_id: message.id)

    if karma
      karma.destroy
    else
      save_karma(message, data)
    end
  end

  def save_karma(message, data)
    Karma.create(user_id: data['user_id'],
                 reviewer_id: data['reviewer_id'],
                 message_id: message.id,
                 point: 1)
  end
end
