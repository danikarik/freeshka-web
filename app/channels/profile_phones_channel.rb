class ProfilePhonesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user:#{current_user.id}:phones"
  end

  def unsubscribed
    stop_all_streams
  end

  def add_phone(data)
    phone = find_phone(data['number'])
    if phone
      PhoneRelayJob.perform_later(phone, current_user,
                                  I18n.t('phone.duplicated'))
    else
      phone = Phone.create(number: data['number'],
                           is_verified: false,
                           user_id: current_user.id)

      PhoneRelayJob.perform_later(phone, current_user, '')
    end
  end

  private

  def find_phone(number)
    Phone.find_by(number: number)
  end
end
