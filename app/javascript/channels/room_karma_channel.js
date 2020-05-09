import consumer from "./consumer"

export default consumer.subscriptions.create("RoomKarmaChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const voteBtn = document.querySelector(`button[data-id="${data.id}"]`)
    if (voteBtn) {
      const spans = voteBtn.parentNode.getElementsByTagName("span")
      if (spans.length > 0) {
        spans[0].textContent = data.karma
      }
    }
  },

  upvoteMessage(data) {
    this.perform("upvote_message", {
      user_id: data.user,
      reviewer_id: data.reviewer,
      message_id: data.message,
    })
  },
})
