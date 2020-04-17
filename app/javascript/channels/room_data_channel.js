import consumer from "./consumer"

function getChatContainer(data) {
  return document.querySelectorAll(`[data-chat-room="${data.room_id}"]`)
}

function getMessages(chat) {
  return chat[0].querySelectorAll(`[data-behavior="messages"]`)
}

export default consumer.subscriptions.create("RoomDataChannel", {
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
        if (data.messages.length > 0) {
          const currentScrollHeight = messages[0].scrollHeight

          data.messages.map((message) => {
            messages[0].insertAdjacentHTML("afterbegin", message)
          })

          messages[0].scrollTop = messages[0].scrollHeight - currentScrollHeight
        }
      }
    }
  },

  requestMessages(data) {
    this.perform("request_messages", {
      room_id: data.room,
      last_id: data.lastId,
    })
  },
})
