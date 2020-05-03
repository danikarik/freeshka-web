import consumer from "./consumer"

function getPhonesContainer() {
  return document.querySelectorAll(`[data-target="profile-phone.container"]`)
}

export default consumer.subscriptions.create("ProfilePhonesChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const container = getPhonesContainer()
    if (container.length > 0) {
      container[0].insertAdjacentHTML("beforeend", data.phone)
    }
  },

  addPhone(data) {
    this.perform("add_phone", { number: data.number })
  },
})
