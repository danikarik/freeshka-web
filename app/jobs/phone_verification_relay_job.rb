class PhoneVerificationRelayJob < ApplicationJob
  queue_as :default

  def perform(phone, current_user)
    ActionCable.server.broadcast "user:#{current_user.id}:phones:verification", {
      phone: phone
    }
  end
end
