import consumer from "./consumer"

consumer.subscriptions.create("RoomsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const activeRoom = document.querySelectorAll(`[data-behavior="messages"][data-room-id="${data.room_id}"]`)
    if (activeRoom.length > 0) {
      activeRoom[0].insertAdjacentHTML('beforeend', data.message)
    } else {
      const roomLink = document.querySelectorAll(`[data-behavior="room-link"][data-room-id="${data.room_id}"]`)
      if (roomLink.length > 0) {
        roomLink[0].classList.add('font-semibold')
      }
    }
  }
});
