class PhoneVerificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user:#{current_user.id}:phones:verification"
  end

  def unsubscribed
    stop_all_streams
  end

  def send_request(data)
    phone = Phone.find(data['id'])

    return unless phone

    phone.assign_verification_code
    phone.save
  end

  def confirm_request(data)
    phone = Phone.find(data['id'])

    return unless phone

    phone.verify_code(data['code'])
    phone.save

    PhoneVerificationRelayJob.perform_later(phone, current_user)
  end
end
