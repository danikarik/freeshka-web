import consumer from "./consumer"

export default consumer.subscriptions.create("PhoneVerificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.phone.is_verified) {
      console.log("phone number verified")
    }
  },

  sendRequest(data) {
    this.perform("send_request", { id: data.id })
  },

  confirmRequest(data) {
    this.perform("confirm_request", { id: data.id, code: data.code })
  },
})
