import consumer from "./consumer"

function getChatContainer(data) {
  return document.querySelectorAll(`[data-chat-room="${data.room_id}"]`)
}

function getMessages(chat) {
  return chat[0].querySelectorAll(`[data-behavior="messages"]`)
}

function getRoomLink(data) {
  return document.querySelectorAll(`[data-behavior="room-link"][data-room-id="${data.room_id}"]`)
}

export default consumer.subscriptions.create("RoomsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const chat = getChatContainer(data)
    if (chat.length > 0) {
      const messages = getMessages(chat)
      if (messages.length > 0) {
        messages[0].insertAdjacentHTML("beforeend", data.message)

        if (document.hidden && Notification.permission === "granted") {
          new Notification(data.user, { body: data.body })
        }
      } else {
        const roomLink = getRoomLink(data)
        if (roomLink.length > 0) {
          roomLink[0].classList.add("font-semibold")
        }
      }
    }
  },

  sendMessage(data) {
    this.perform("send_message", {
      room_id: data.room,
      body: data.body,
    })
  },
})
