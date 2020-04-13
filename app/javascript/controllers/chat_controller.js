import { Controller } from "stimulus"
import roomChannel from "../channels/rooms_channel"

export default class extends Controller {
  static targets = ["form", "input"]

  connect() {
    this.inputTarget.addEventListener("keypress", this.handleEnterPressed())
  }

  disconnect() {
    this.inputTarget.removeEventListener("keypress", this.handleEnterPressed())
  }

  send() {
    // this.formTarget.submit()
    const data = {
      room: this.room,
      body: this.inputTarget.value,
    }

    roomChannel.sendMessage(data)

    this.inputTarget.value = ""
  }

  handleEnterPressed() {
    return (e) => {
      if (e.keyCode === 13) {
        e.preventDefault()
        this.send()
      }
    }
  }

  get room() {
    return parseInt(this.data.get("room"))
  }
}
