class PhoneRelayJob < ApplicationJob
  queue_as :default

  def perform(phone, current_user, error)
    ActionCable.server.broadcast "user:#{current_user.id}:phones", {
      error: error,
      phone: ApplicationController.render(partial: 'phones/phone',
                                          locals: { phone: phone })
    }
  end
end
