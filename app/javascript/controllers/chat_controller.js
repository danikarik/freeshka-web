import { Controller } from "stimulus"
import roomChannel from "../channels/rooms_channel"
import lastReadChannel from "../channels/last_read_channel"

export default class extends Controller {
  static targets = ["form", "input"]

  connect() {
    this.inputTarget.addEventListener("keypress", this.handleEnterPressed())
    document.addEventListener("click", this.handleActivityResume())
  }

  disconnect() {
    this.inputTarget.removeEventListener("keypress", this.handleEnterPressed())
    document.removeEventListener("click", this.handleActivityResume())
  }

  send() {
    roomChannel.sendMessage({
      room: this.room,
      body: this.inputTarget.value,
    })

    this.inputTarget.value = ""
  }

  update() {
    const divider = document.getElementById("unread")
    if (divider !== null) {
      lastReadChannel.update({ room: this.room })
      divider.parentNode.removeChild(divider)
    }
  }

  handleEnterPressed() {
    return (e) => {
      if (e.keyCode === 13) {
        e.preventDefault()
        if (this.inputTarget.value !== "") {
          this.send()
        }
      }
    }
  }

  handleActivityResume() {
    return (e) => {
      this.update()
    }
  }

  get room() {
    return parseInt(this.data.get("room"))
  }
}
