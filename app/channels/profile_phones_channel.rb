class ProfilePhonesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "profile:#{current_user.id}:phones"
  end

  def unsubscribed
    stop_all_streams
  end

  def add_phone(data)
    phone = Phone.create(number: data['number'],
                         is_verified: false,
                         user_id: current_user.id)
    PhoneRelayJob.perform_later(phone, current_user)
  end
end
