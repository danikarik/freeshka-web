import { Controller } from "stimulus"
import roomChannel from "../channels/rooms_channel"
import lastReadChannel from "../channels/last_read_channel"

export default class extends Controller {
  static targets = ["form", "input"]

  connect() {
    this.inputTarget.addEventListener("keypress", this.handleEnterPressed())
    document.addEventListener("click", this.handleVisibilityChanged())
  }

  disconnect() {
    this.inputTarget.removeEventListener("keypress", this.handleEnterPressed())
    document.removeEventListener("click", this.handleVisibilityChanged())
  }

  send() {
    const data = {
      room: this.room,
      body: this.inputTarget.value,
    }

    roomChannel.sendMessage(data)

    this.inputTarget.value = ""
  }

  update() {
    const strikes = document.getElementsByTagName("hr")
    if (strikes.length > 0) {
      lastReadChannel.update({ room: this.room })

      while (strikes[0]) strikes[0].parentNode.removeChild(strikes[0])
    }
  }

  handleEnterPressed() {
    return (e) => {
      if (e.keyCode === 13) {
        e.preventDefault()
        this.send()
      }
    }
  }

  handleVisibilityChanged() {
    return (e) => {
      this.update()
    }
  }

  get room() {
    return parseInt(this.data.get("room"))
  }
}
